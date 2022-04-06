Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25DE4F5D74
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiDFMHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiDFMGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B9E72F2F19
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 00:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649231280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tnMN3pUaj7lJGkHw7ZLvt0aTt3QjufyLZHnTLczmUJE=;
        b=ZHD3RBHYJUhUtxjgM2rMOgpE09EHsaF1eOMsiBtvDX/SSYJFGN22Fzm5NezPq3o+Punulu
        sotrBOKgiuyO8ZK4JxbHUAlHn+otnFWi/lu0DZg7IcusWLTgfcYjWD6QvAz5gkNYnXgT7x
        lg2Sx4nxTUHPIi3JHjNuwhe3H1namck=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-73-xF_iw_bAOcuQmyPsaDbJZQ-1; Wed, 06 Apr 2022 03:47:59 -0400
X-MC-Unique: xF_iw_bAOcuQmyPsaDbJZQ-1
Received: by mail-ej1-f69.google.com with SMTP id nd34-20020a17090762a200b006e0ef16745cso727853ejc.20
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 00:47:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tnMN3pUaj7lJGkHw7ZLvt0aTt3QjufyLZHnTLczmUJE=;
        b=eV6n6fMFcIVPQiCslR9SNUdmHjNiD+/ilbIzNN4OgXgi5V8Ston1T/8HbCrkq3l/HW
         2m0P/KZbVI3K7ydnQ5brj++Rde7BMILyBviCsr7+B4dKMOUrJBXKsMV9DVr9eFfnynNl
         YumK6fbcY4bjYJOd3aG9vVgHuRNY0yDn2BzUdVnIIPJp1UY/xiHir2BHHam1jdebMkUi
         oxMIn5goPonF6298zxBGVgE3Nue1FrhWMtQ4/Otx9KVBLM+v01bQcEMs6cdWEUkiz1ko
         VCcY89GAm3YWoLGPWHP3/ZME/cEaPXPHA0Fr1GWoW/4NH2QcBHBKtAJD1n71Bno/fAgy
         YWHw==
X-Gm-Message-State: AOAM531u7gFWHyU1EKCSQux2G8wsTxblB7dRAorlpcW3rvCw3Mynuj/v
        ORyqWBPP8/iq/6kAnOKUEIh7zlweHvF+gAAURXLK+eu7RTbRI37RHk5mejswPkJatgYlSY/+9vd
        GsjBjOdN9q6jotsYNT4oL7wf5
X-Received: by 2002:a05:6402:183:b0:410:fde:887a with SMTP id r3-20020a056402018300b004100fde887amr7228689edv.243.1649231278380;
        Wed, 06 Apr 2022 00:47:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLcLipZLH882pfJA3h0lLGi++W3jsGhKM/fA7YIjyDbCflYB4XnGKFeaNybu/dm01/9LLhtA==
X-Received: by 2002:a05:6402:183:b0:410:fde:887a with SMTP id r3-20020a056402018300b004100fde887amr7228671edv.243.1649231278152;
        Wed, 06 Apr 2022 00:47:58 -0700 (PDT)
Received: from redhat.com ([2.53.144.12])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709062a5700b006ccd8fdc300sm6132409eje.180.2022.04.06.00.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 00:47:57 -0700 (PDT)
Date:   Wed, 6 Apr 2022 03:47:53 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     zhenwei pi <pizhenwei@bytedance.com>, arei.gonglei@huawei.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        herbert@gondor.apana.org.au, helei.sig11@bytedance.com
Subject: Re: [PATCH v3 0/4] Introduce akcipher service for virtio-crypto
Message-ID: <20220406034721-mutt-send-email-mst@kernel.org>
References: <20220302033917.1295334-1-pizhenwei@bytedance.com>
 <a9d1dfc1-080e-fba2-8fbb-28718b067e0d@bytedance.com>
 <20220307040431-mutt-send-email-mst@kernel.org>
 <87h778g8nn.fsf@redhat.com>
 <20220405012015-mutt-send-email-mst@kernel.org>
 <87ee2cexp5.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ee2cexp5.fsf@redhat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 10:33:42AM +0200, Cornelia Huck wrote:
> On Tue, Apr 05 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Apr 04, 2022 at 05:39:24PM +0200, Cornelia Huck wrote:
> >> On Mon, Mar 07 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Mon, Mar 07, 2022 at 10:42:30AM +0800, zhenwei pi wrote:
> >> >> Hi, Michael & Lei
> >> >> 
> >> >> The full patchset has been reviewed by Gonglei, thanks to Gonglei.
> >> >> Should I modify the virtio crypto specification(use "__le32 akcipher_algo;"
> >> >> instead of "__le32 reserve;" only, see v1->v2 change), and start a new issue
> >> >> for a revoting procedure?
> >> >
> >> > You can but not it probably will be deferred to 1.3. OK with you?
> >> >
> >> >> Also cc Cornelia Huck.
> >> 
> >> [Apologies, I'm horribly behind on my email backlog, and on virtio
> >> things in general :(]
> >> 
> >> The akcipher update had been deferred for 1.2, so I think it will be 1.3
> >> material. However, I just noticed while browsing the fine lwn.net merge
> >> window summary that this seems to have been merged already. That
> >> situation is less than ideal, although I don't expect any really bad
> >> problems, given that there had not been any negative feedback for the
> >> spec proposal that I remember.
> >
> > Let's open a 1.3 branch? What do you think?
> 
> Yes, that's probably best, before things start piling up.

OK, want to do it? And we can then start voting on 1.3 things
straight away.

-- 
MST

