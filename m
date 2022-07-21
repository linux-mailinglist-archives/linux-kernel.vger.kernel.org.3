Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9077C57C30C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 05:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbiGUD4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 23:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiGUD4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 23:56:41 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB11E2314C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:56:40 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b9so607621pfp.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 20:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PXcLbgz/2hZNyRCKVpHDt9L+ugWOOu7ycGEMz9duFt8=;
        b=AJSGr9MeESvQ1BHuYg1u20EvRDhzIGuqU/qnzvueLooOm1yNr/hPAB5/H9UranvqHZ
         HICW03++IDk+ajH9p05A+tyzubpVbPftxEsMB2MU7u0YJPfcL/0eaZh24Ps/e/sFPFLG
         nzN0ESbxRKM+vq+6WBt8SrdXQuVBA7J1hEUq+I28qguMQ7R2tow+tOQGoALabymobz3B
         k32UK50Wh3FaTUniZmirR2TylU+VeApcWFbANPgHr1+yCjUktIGoXj32PSCMlXOsh1hl
         lZvJxQKhAde9eOM4wL8MnCO/YHya95Xrqfksxcxm+zJvBeMoX9aTlbw6PAt8LXEoNEgh
         0EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PXcLbgz/2hZNyRCKVpHDt9L+ugWOOu7ycGEMz9duFt8=;
        b=ZeUn4lJ0GJBDmPPMMb5d/qbOb1wESwFTe2mozgjygvh3hzdiG3eINqREH7E/wdSW6H
         wM0KXLeoB2S6ZpTjMqyXxEtTagC94DsAeKsda+yrbdsonbdXIpPA+NDAnSIMo3xz8qFQ
         /VGivzf4wMYgcO4A6egYwl9FlAphmQhd4bfFt+T2nXpPtcW3bHjd4k6mTG4bliT+ax3R
         C6xqf8u5jywAYrTFSyxDAvTIvYobr2xtSpSG9YrWyrGE/CokUAvrtzSB0EjyV8az0oWv
         YXFtwauwVFXQonTi1UW+1cYU8g1wi3GSJy+dDy66gqKhyWl1pkXs2BfI1qok0XTPlQOD
         KbLg==
X-Gm-Message-State: AJIora+QyENZRaAxAPtrqieRaQtDUPXsccJeWYIRgZSbc9rgkjeFCUH8
        YRbsUIKYppK/9rJh8aqbZ2TpWeT+TmnUkuixpkm9Qw==
X-Google-Smtp-Source: AGRyM1scp+RxkXYyOzwQDID4GtfVxc+vRqVJDCM7uEyTprEdPloEgysXH9XVJicMOkA8UnVjHPANGWoIaIUR8oMviog=
X-Received: by 2002:a65:6e93:0:b0:419:acad:f06b with SMTP id
 bm19-20020a656e93000000b00419acadf06bmr32290788pgb.68.1658375800209; Wed, 20
 Jul 2022 20:56:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:d06f:0:b0:535:c52f:e1cf with HTTP; Wed, 20 Jul 2022
 20:56:39 -0700 (PDT)
X-Originating-IP: [24.53.241.20]
In-Reply-To: <9122f83f-902b-3738-3b0e-f806df999c3f@linux.alibaba.com>
References: <20220720015538.15838-1-nbowler@draconx.ca> <9122f83f-902b-3738-3b0e-f806df999c3f@linux.alibaba.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Wed, 20 Jul 2022 23:56:39 -0400
Message-ID: <CADyTPExY4TOuy1pboWLiTRpjmKiLZkkGUqcnL1dGdSwviMapZA@mail.gmail.com>
Subject: Re: [PATCH] nvme: Define compat_ioctl again to unbreak 32-bit userspace.
To:     Guixin Liu <kanie@linux.alibaba.com>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-19, Guixin Liu <kanie@linux.alibaba.com> wrote:
> =E5=9C=A8 2022/7/20 09:55, Nick Bowler =E5=86=99=E9=81=93:
[...]
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index a2862a56fadc..30e105dbc178 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2093,6 +2093,7 @@ static int nvme_report_zones(struct gendisk *disk,
>> sector_t sector,
>>   static const struct block_device_operations nvme_bdev_ops =3D {
>>   	.owner		=3D THIS_MODULE,
>>   	.ioctl		=3D nvme_ioctl,
>> +	.compat_ioctl	=3D nvme_ioctl,
>>   	.open		=3D nvme_open,
>>   	.release	=3D nvme_release,
>>   	.getgeo		=3D nvme_getgeo,
[...]
> Should this in the brace of "#ifdef CONFIG_COMPAT" and "#endif"?

I think it doesn't make any significant difference either way -- the
.compat_ioctl member is always present in the block_device_operations
structure.  Unconditional assignment thus seems more sensible to me.

v2 uses blkdev_compat_ptr_ioctl which expands to NULL for !CONFIG_COMPAT.

Thanks,
  Nick
