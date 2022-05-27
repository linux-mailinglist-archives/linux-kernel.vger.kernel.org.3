Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F29535807
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 05:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiE0DYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 23:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238161AbiE0DYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 23:24:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7873CBA7
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653621840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNB6nm9imnMhEWbze1yFT3zEAHFqyZg1VlwYfSvOk60=;
        b=W5CLzHbehrmYxKdNm/vayEP0/yN8b3nOfsiUhhgo2FgNj3bVFqBHQxhiIMWYFHT/DcREsf
        ShoV6koBYXLdRd9zr0mKIYHwQb19l4EG0ps0l6edo0f0qDNrPdVE8JmGJDnsARsGBrTEju
        BpC5YaAOyFAmPx1sI+G3KUI95EMfyuw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-CjbQWnsdPUqvO9XNFsPYQw-1; Thu, 26 May 2022 23:23:57 -0400
X-MC-Unique: CjbQWnsdPUqvO9XNFsPYQw-1
Received: by mail-lf1-f69.google.com with SMTP id g11-20020a05651222cb00b0047872568226so1437008lfu.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:23:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CNB6nm9imnMhEWbze1yFT3zEAHFqyZg1VlwYfSvOk60=;
        b=uPdcjyfaZfxWeRTLvMP59bm3saDTqTJB96OWiOoUCmNYUTV4y64BkUsV75jEEThyb4
         sKy4KGhvfJ3i6buL9/3pp2DYRdrg6UjrY952LV+hM0HQtDgy9ditExykqrL9wXMTdnWi
         SKogikQS9hMUry0k0EyzA+gN6vJGmIDszNebBAhkuZbNcIDkTHP1FTPVSKHs8lwOUkjp
         ocwwUEUesqdUzmB9lNO5RQXvN/U62b5YiEQ/jQHwN5rQPDNQMaKMSECATLdP4LC3FLAF
         HluhbDPKNhTQmYXKOcDVRNAHxCwufYrq+Q1lH6ZnllKCh+XD7egDFrwkdvgx5ZZpdL4x
         DoiA==
X-Gm-Message-State: AOAM532KKTCxKVIU6iHuDJoMVdftXMunrCZc0908tCtRPtPT/JQHLGSX
        ih+VP/OYgkdrZTUra5DPrQxEmUsuWOkNTfkzbPL7utgmP/aSp5LDGqIEwAVtfdfdqCQ1l4k1Hp3
        8k4rUdvXGc6tViLD1cGnwEwmEXFj0RG2vvZw3h+gW
X-Received: by 2002:a2e:5cc1:0:b0:24b:112f:9b36 with SMTP id q184-20020a2e5cc1000000b0024b112f9b36mr24329264ljb.337.1653621836119;
        Thu, 26 May 2022 20:23:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzq3AlLTRcpnjnf5ISdbmeT1DeOP1a/lGEm/pg7/4+6KtuWTkqiDk1gciDqLWDM7rD1v++15SIHQAin5xa37y4=
X-Received: by 2002:a2e:5cc1:0:b0:24b:112f:9b36 with SMTP id
 q184-20020a2e5cc1000000b0024b112f9b36mr24329245ljb.337.1653621835775; Thu, 26
 May 2022 20:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220525172427.3692-1-lhenriques@suse.de> <fb3d817d8b6235472e517a9fc9ad0956fb4e8cf2.camel@kernel.org>
 <3cb96552-9747-c6b4-c8d3-81af60e5ae6a@redhat.com> <ca4928507bdf329bbe5b32a7b71f4a4295e5bba1.camel@kernel.org>
 <f238e4a1-ef98-ccfe-6345-51b6d9a34319@redhat.com>
In-Reply-To: <f238e4a1-ef98-ccfe-6345-51b6d9a34319@redhat.com>
From:   Gregory Farnum <gfarnum@redhat.com>
Date:   Thu, 26 May 2022 20:23:39 -0700
Message-ID: <CAJ4mKGZyw+uKjwkSBseETtKXwJOSV2D8J9mLH-8yB8w98Ow=fA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] ceph: prevent a client from exceeding the MDS
 maximum xattr size
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        =?UTF-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 6:10 PM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 5/27/22 8:44 AM, Jeff Layton wrote:
> > On Fri, 2022-05-27 at 08:36 +0800, Xiubo Li wrote:
> >> On 5/27/22 2:39 AM, Jeff Layton wrote:
> >>> A question:
> >>>
> >>> How do the MDS's discover this setting? Do they get it from the mons?=
 If
> >>> so, I wonder if there is a way for the clients to query the mon for t=
his
> >>> instead of having to extend the MDS protocol?
> >> It sounds like what the "max_file_size" does, which will be recorded i=
n
> >> the 'mdsmap'.
> >>
> >> While currently the "max_xattr_pairs_size" is one MDS's option for eac=
h
> >> daemon and could set different values for each MDS.
> >>
> >>
> > Right, but the MDS's in general don't use local config files. Where are
> > these settings stored? Could the client (potentially) query for them?
>
> AFAIK, each process in ceph it will have its own copy of the
> "CephContext". I don't know how to query all of them but I know there
> have some API such as "rados_conf_set/get" could do similar things.
>
> Not sure whether will it work in our case.
>
> >
> > I'm pretty sure the client does fetch and parse the mdsmap. If it's
> > there then it could grab the setting for all of the MDS's at mount time
> > and settle on the lowest one.
> >
> > I think a solution like that might be more resilient than having to
> > fiddle with feature bits and such...
>
> Yeah, IMO just making this option to be like the "max_file_size" is more
> appropriate.

Makes sense to me =E2=80=94 this is really a property of the filesystem, no=
t a
daemon, so it should be propagated through common filesystem state.
I guess Luis' https://github.com/ceph/ceph/pull/46357 should be
updated to do it that way? I see some discussion there about handling
old clients which don't recognize these limits as well.
-Greg

