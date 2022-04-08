Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5388A4F8EE3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbiDHG2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 02:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbiDHG2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 02:28:22 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46393198534
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 23:26:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id h5so6014706pgc.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 23:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g35dmgX32k/R7TxnuKRf02cyb1nmI23wQu6jsuLVbVU=;
        b=wlSIBbbSFHb+JhPPPwZhYXbD7WTAYzJ9ooeCOJ4TJorGTR9S6YbwY6kt+RuyigO524
         kMvXQrASEbH6rcmScjaHvcogjfqkb8NJlfaBW2HLpnN56HWsI5uwggQ+dYV/aoIepw/E
         nURCc8MnNjmA0kvJ5xVOTCAndDTK2kjR54OW2WJBfuINbnBPEn1OXIKcmO1sLyaob2Ed
         9WV7jQkkHpFjZGrAf5cVdT00/H55NyENNDR9ohZpO6Hq09QYEVUxnOtII9fZ0Q0VRD+x
         sv0Gji5mFmzwSVQRwIxHosZoXz1DCVg7lzTFeipG8MZ1kmYnGngZUkUnKri1pi1o27UQ
         FLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g35dmgX32k/R7TxnuKRf02cyb1nmI23wQu6jsuLVbVU=;
        b=A3YQofI2npV2IgWpi5v2KG3eBmP3VFWM0sjWw3hwhzH787dJdYh8mwjiXXGhuL/Lnj
         FBXsIjm4Vq+g5mUEO+59D8cuFChg6rMde4K2fYRozw+Zl33wlpvsDDPtWu2R9DD7K3l7
         U8M+MCLa1s5FP8OxIXefPj495b7QduOr9rXDs+jYLBaVNLz7b1mVtB65/uEplcXo7JCV
         z0c2I6CVko/EMLvpVUxuGvKEUDs45hEcuJ4z0XMxZZT5XW9at9Z0mtwhXTy5bQwVUmno
         Arb7x83vVFtVP3gOZrJbXWl2UvrDDdYgCe8ruQ3INIt7+0spMSstcaaAPFaFrmwANIro
         iSZA==
X-Gm-Message-State: AOAM530bIUlkR1Jbv/Pj42cMCce/o/H8lnbyfNfTju4/BVDPJY93mU04
        DCybg3n2gw4uCbpa1oTri3lpZD7PVVveWRjly2Hvcw==
X-Google-Smtp-Source: ABdhPJwZpPAQGEBsOe2H4Ew1tYOWqLCmIf5LQhtcpsvQh/Ztm9JTK+n38+TDSeB0NMkBLck/NVWRLJvt/A/qt2vd7YI=
X-Received: by 2002:a05:6a00:8c5:b0:4fe:134d:30d3 with SMTP id
 s5-20020a056a0008c500b004fe134d30d3mr18016783pfu.3.1649399178836; Thu, 07 Apr
 2022 23:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-8-ruansy.fnst@fujitsu.com> <YkPyBQer+KRiregd@infradead.org>
 <8f1931d2-b224-de98-4593-df136f397eb4@fujitsu.com>
In-Reply-To: <8f1931d2-b224-de98-4593-df136f397eb4@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 7 Apr 2022 23:26:08 -0700
Message-ID: <CAPcyv4jO+-JkRcwZk0ZuYaGy0NDx2iZg-GjnDLWqVFYvciFF4g@mail.gmail.com>
Subject: Re: [PATCH v11 7/8] xfs: Implement ->notify_failure() for XFS
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, david <david@fromorbit.com>,
        Jane Chu <jane.chu@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 11:05 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrot=
e:
>
>
>
> =E5=9C=A8 2022/3/30 14:00, Christoph Hellwig =E5=86=99=E9=81=93:
> >> @@ -1892,6 +1893,8 @@ xfs_free_buftarg(
> >>      list_lru_destroy(&btp->bt_lru);
> >>
> >>      blkdev_issue_flush(btp->bt_bdev);
> >> +    if (btp->bt_daxdev)
> >> +            dax_unregister_holder(btp->bt_daxdev, btp->bt_mount);
> >>      fs_put_dax(btp->bt_daxdev);
> >>
> >>      kmem_free(btp);
> >> @@ -1939,6 +1942,7 @@ xfs_alloc_buftarg(
> >>      struct block_device     *bdev)
> >>   {
> >>      xfs_buftarg_t           *btp;
> >> +    int                     error;
> >>
> >>      btp =3D kmem_zalloc(sizeof(*btp), KM_NOFS);
> >>
> >> @@ -1946,6 +1950,14 @@ xfs_alloc_buftarg(
> >>      btp->bt_dev =3D  bdev->bd_dev;
> >>      btp->bt_bdev =3D bdev;
> >>      btp->bt_daxdev =3D fs_dax_get_by_bdev(bdev, &btp->bt_dax_part_off=
);
> >> +    if (btp->bt_daxdev) {
> >> +            error =3D dax_register_holder(btp->bt_daxdev, mp,
> >> +                            &xfs_dax_holder_operations);
> >> +            if (error) {
> >> +                    xfs_err(mp, "DAX device already in use?!");
> >> +                    goto error_free;
> >> +            }
> >> +    }
> >
> > It seems to me that just passing the holder and holder ops to
> > fs_dax_get_by_bdev and the holder to dax_unregister_holder would
> > significantly simply the interface here.
> >
> > Dan, what do you think?
>
> Hi Dan,
>
> Could you give some advise on this API?  Is it needed to move
> dax_register_holder's job into fs_dax_get_by_bdev()?


Yes, works for me to just add them as optional arguments.
