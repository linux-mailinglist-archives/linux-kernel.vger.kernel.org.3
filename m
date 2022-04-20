Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16873508C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 17:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380259AbiDTPab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 11:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbiDTPa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 11:30:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 30B3045AC7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650468462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/8Ka6GvZhFRkfzLxzT1UbmtWFPhhmqZ+X1PdVTRfmEs=;
        b=AO6VC09n2J6MJ/s9sl/fEswPs/0FYODTaN+8jws6eUCAwvIgjjkXx6rBDVLbMsx61VrrBq
        mu8RNVKEf+oznrXc0Tue2bPxcR8rN8ot5+JsxPDv26LkwOgmKpRUbO4k0DkeCi3B/4SV1i
        aqnCDVhsf/2CkML0Knhkf9X79YB0Qps=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-XP-iuyOZNwad_uqyqIU4Jg-1; Wed, 20 Apr 2022 11:27:40 -0400
X-MC-Unique: XP-iuyOZNwad_uqyqIU4Jg-1
Received: by mail-qk1-f199.google.com with SMTP id ay14-20020a05620a178e00b0069a9c319c64so1461769qkb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 08:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/8Ka6GvZhFRkfzLxzT1UbmtWFPhhmqZ+X1PdVTRfmEs=;
        b=h707aH821gEIO8J6pDDo0/ljbsiQGl0C9K2W0eWIMxIdCrUvipG7LX4qCZsQvFOeMv
         9dY0971gM2l65jrlJ290PQvqkj0pPhBdMG2+JQEo5qUSiyHkJ+19PV2YkTL+yJFpZc/m
         9H/RbEaIhdm3UpsA3jRnpT2js8DMuzvN131OwOk026LQVE5FowOb5dS0o+4q0wIEfDh0
         FMtcI6USJkUwcwkpDhkFyJ4FM1G9vzyPn1ToLTFmXh8SHZeMmSFzMBRJQ0S3iWFZCmSl
         vkDooH2nAGrloYumj7MssXwmdVztCfPkVmD38Ifw9ggkEzSqfmDz2MhMcnbtQk88q49E
         ufqg==
X-Gm-Message-State: AOAM531rkUG6eGtlxBmVlEaai/ORdPZ3M9VAlHua7wCNnketc+Hdu2Nh
        kK33Igk//+SvTMjp8DZj2m53xmECO/kZtWnp2GQHfeqY8v3rg205kHlNYNZIDe0zx0TN1sKzeuy
        x6NYlSPmHmibEwwGrlF+yyICB
X-Received: by 2002:a05:622a:46:b0:2f2:9b12:5375 with SMTP id y6-20020a05622a004600b002f29b125375mr7452067qtw.625.1650468460271;
        Wed, 20 Apr 2022 08:27:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn3nxAFYXT+zwaS7qYVDdc6sBZB4FBKPMFC5LGoK+YCn4oDeo/3RBWzPylWFA333pfcvcIBQ==
X-Received: by 2002:a05:622a:46:b0:2f2:9b12:5375 with SMTP id y6-20020a05622a004600b002f29b125375mr7452046qtw.625.1650468459998;
        Wed, 20 Apr 2022 08:27:39 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id c23-20020a05620a201700b0069c7c8d1b9fsm1621839qka.21.2022.04.20.08.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 08:27:39 -0700 (PDT)
Date:   Wed, 20 Apr 2022 08:27:36 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, brgerst@gmail.com, jiangshanlai@gmail.com,
        Andrew.Cooper3@citrix.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86: Simplify Retpoline thunk
Message-ID: <20220420152736.qzl3nikds6mq5nrr@treble>
References: <20220419204109.520779286@infradead.org>
 <20220419205241.280037046@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220419205241.280037046@infradead.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:41:10PM +0200, Peter Zijlstra wrote:
> Now that we rewrite all the indirect call sites, per commit:
> 
>   750850090081 ("x86/alternative: Implement .retpoline_sites support")
> 
> it doesn't make sense to have the retpoline thunks be an ALTERNATIVE_2
> that still includes a 'naked' indirect jump.
> 
> (this accidentally 'defunnels' i386 by going back to full retpolines)

So mitigations=off no longer works on i386?

Is funneling even a concern on i386?  I don't think it has eIBRS anyway,
or does it?

-- 
Josh

