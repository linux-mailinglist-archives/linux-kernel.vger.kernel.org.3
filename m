Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8185F576732
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 21:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiGOTKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 15:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGOTKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 15:10:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C42C53DBE5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657912199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YwoLVFK6VIqRxOLsO1/EQV9lnSFDUSQaM1LO6cP8vkU=;
        b=TfJcolO7pijnOg/h/DZd0ZA2iI9ANvqBovNXGiNbuEgb04FyR4i3h6JOcM9gQklbnGffA9
        p182UmdGKhQEzWQqWVAf4B+miKJN8n2j2KZK5P2e7BGmlE9VqmPouxLm167YAZ2dB4anpY
        Con7c7bkLKsi/qUYfAoEhubYowanrPU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-378-U4TX0dV6OdODP5z44GRNog-1; Fri, 15 Jul 2022 15:09:51 -0400
X-MC-Unique: U4TX0dV6OdODP5z44GRNog-1
Received: by mail-qv1-f71.google.com with SMTP id d18-20020a0cfe92000000b0047342562073so3490616qvs.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 12:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=YwoLVFK6VIqRxOLsO1/EQV9lnSFDUSQaM1LO6cP8vkU=;
        b=7P0LR41qLqjMntGP8afwnOPLot2001Th8xAc66E2rHFF518INl7NjxJ7t06LvhIpi9
         S2uSuP+UpvkspPoyEwsnzhTSiohJArRpETB2oCPhXJnPkFvxLGgqKB7sDrzdm+CvNUqG
         k40zc9q/6EtaEKDvUqMJu/UwWMOXL8hAi9ReAIkJ+GH6xinH2gtDhHjMKVs1tQUOOvsG
         VIP2gcd6ZPdgACDV7ghCp8snMPpV1U7mHRzjkZMT2G28Vc7f6Wmsphcn7wBkJKDHSbq8
         uuaa2JWkiSo1RUo0cFtMz1NZ/v19INtWYRfzzrr+QfSPkV4pVHDfwoNZSCXtJiZBlwQQ
         Q+XQ==
X-Gm-Message-State: AJIora9aZIaS3wvF1o7ycRUsMeXDVb0Fn54UU/wqhzQ4F/HhaKlEMCSS
        uT05Sahrh1Sa/Pt/rqG6iUtzbILNgoDxqb2gkui5N0iqJ7z3lwQ4xMox1QEC25KmpsNGdnvk9NB
        cue/JBmGAXVii77ngd96Qk+LN
X-Received: by 2002:a05:6214:3009:b0:473:990:6d08 with SMTP id ke9-20020a056214300900b0047309906d08mr13082704qvb.121.1657912190540;
        Fri, 15 Jul 2022 12:09:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uohAkD70j3BSA3vDDBqmY1M2p1cVekKFciRB3de2UGHqsYQMYVH4O+M/IUZxKTSkZXjTdv5A==
X-Received: by 2002:a05:6214:3009:b0:473:990:6d08 with SMTP id ke9-20020a056214300900b0047309906d08mr13082681qvb.121.1657912190247;
        Fri, 15 Jul 2022 12:09:50 -0700 (PDT)
Received: from [192.168.8.138] ([141.154.49.182])
        by smtp.gmail.com with ESMTPSA id f4-20020ac80684000000b0031eca8c88f6sm4017257qth.51.2022.07.15.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 12:09:49 -0700 (PDT)
Message-ID: <44d6fc01654b16f9cdd6b517999ddec76038d547.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/bios: set info only when the return is not 0
From:   Lyude Paul <lyude@redhat.com>
To:     Tom Rix <trix@redhat.com>, bskeggs@redhat.com, kherbst@redhat.com,
        airlied@linux.ie, daniel@ffwll.ch, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Date:   Fri, 15 Jul 2022 15:09:48 -0400
In-Reply-To: <91194b7190081545a8eeb10d20e24de864dfe259.camel@redhat.com>
References: <20220702153904.1696595-1-trix@redhat.com>
         <91194b7190081545a8eeb10d20e24de864dfe259.camel@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-04 at 17:32 -0400, Lyude Paul wrote:
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> 
> Currently on flakey internet in the back of a car, so I probably won't be
> able
> to push this until I get back tonight or early tomorrow

Whoops! Slipped my mind when I got back, but I just remembered it now so I
will go ahead and push :). apologies for the delay!

> 
> On Sat, 2022-07-02 at 11:39 -0400, Tom Rix wrote:
> > clang static analysis reports
> > drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c:68:17: warning: The right
> > operand of '*' is a garbage value [core.UndefinedBinaryOperatorResult]
> >         switch (!!data * *ver) {
> >                        ^ ~~~~
> > A switch statement with only a default should be reduced to an if.
> > 
> > If nvbios_pmuEp() returns 0, via the data variable, the output info
> > parameter
> > is not used.  So set info only when data is not 0.
> > 
> > The struct nvbios_pmuE only has the type and data elements.  Since both of
> > these
> > are explicitly set, memset is not needed.  So remove it.
> > 
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
> > b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
> > index b4a308f3cf7b..49e2664a734c 100644
> > --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
> > +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bios/pmu.c
> > @@ -64,12 +64,9 @@ nvbios_pmuEp(struct nvkm_bios *bios, int idx, u8 *ver,
> > u8
> > *hdr,
> >              struct nvbios_pmuE *info)
> >  {
> >         u32 data = nvbios_pmuEe(bios, idx, ver, hdr);
> > -       memset(info, 0x00, sizeof(*info));
> > -       switch (!!data * *ver) {
> > -       default:
> > +       if (data) {
> >                 info->type = nvbios_rd08(bios, data + 0x00);
> >                 info->data = nvbios_rd32(bios, data + 0x02);
> > -               break;
> >         }
> >         return data;
> >  }
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

