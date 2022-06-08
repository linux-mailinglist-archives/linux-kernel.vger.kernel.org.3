Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1B9543D27
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 21:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235729AbiFHT5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 15:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiFHT5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 15:57:52 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD5B3DDC2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 12:57:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w13-20020a17090a780d00b001e8961b355dso7660588pjk.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 12:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KCcIdF4bqdmfr8ubKRfkXyFIonUIza6ThNxpED8m3mo=;
        b=EOXfKPxvRILHWhdHwsHEIz0IgPWoErm0CvypbNn+YmMYE1wCIOPFYQLM5Pjk0r5j0U
         7DrOiTQ6TZhE6eK6wCbVnTHJtVCvCSUXWFSyv81DNZrUaFNqIJysBDGR36/AQmBX7E3G
         Hl019QYZtmfuD77J90sL9H6QrAHCb0CaQPp9M1MNrjF5UfnRLIxbj/hCs0VRSpHP07wk
         d51WaCUhggbI59F99DCRy6t0iH2OGmoau9fUJp4sWnj+b1qN1xA1ZAPhTI3p+EnLSvQW
         DnTo1Aox2U8y8UuHD8AhXUre45jrt46WN9rUhy+NIceq3Lq6KFII62VO8LTRhy324N/I
         Zzpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KCcIdF4bqdmfr8ubKRfkXyFIonUIza6ThNxpED8m3mo=;
        b=i7hcwo8+6DY8QA1ix2N5p3EfkASqKjV7HUEi4xhG1vQH+AhXTTjD2Ybjm+nEil4DuK
         kObsjCXYn9z7dPj1LjOMC2M+pKGJDx7tCofQjx6O/5wcvIYLETbnRWmrTZgXistyB1h3
         1EiPJu5KKVcgamMSWuKZgeMuyOFsucUUOgO4u9kIjxhPxfTdBYBMLctGL3nHjgq4rQul
         07QeYrPAQiunSB51PHX7oa7+5/PrTRTLLDnrl+x4al4sidhP2XrAUmfgCQ9Yjtwm7noS
         onE8AvVpnwV0n60vCLYyqdAPgTuio3pYyAcIvHTKJPan2dzmmH/h4qcawGZR0rQtS9tO
         fFyg==
X-Gm-Message-State: AOAM5310yJN1RMh1P6IHZs9eNa++bDAvrX856j4gGff8WZgM/6ifRL/4
        CECln2moqpLlqpuJAFbE9LEs4A==
X-Google-Smtp-Source: ABdhPJzme/8tg/Dp9s2wqqCOyNvtCvz6tGbPMASz1ZpKobwC+W6OShIKP4aG0TVY5OF8A9rtobE7Lw==
X-Received: by 2002:a17:90b:180b:b0:1e3:2844:5f63 with SMTP id lw11-20020a17090b180b00b001e328445f63mr883477pjb.164.1654718270681;
        Wed, 08 Jun 2022 12:57:50 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id gq20-20020a17090b105400b001e26da0d28csm14332578pjb.32.2022.06.08.12.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 12:57:49 -0700 (PDT)
Date:   Wed, 8 Jun 2022 19:57:45 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vasant Karasulli <vkarasulli@suse.de>
Cc:     linux-kernel@vger.kernel.org, jroedel@suse.de, kvm@vger.kernel.org,
        bp@alien8.de, x86@kernel.org, thomas.lendacky@amd.com
Subject: Re: [PATCH v6 2/4] x86/tests: Add tests for AMD SEV-ES #VC handling
 Add KUnit based tests to validate Linux's VC handling for instructions cpuid
 and wbinvd. These tests: 1. install a kretprobe on the #VC handler
 (sev_es_ghcb_hv_call, to access GHCB before/after the resulting VMGEXIT). 2.
 trigger an NAE by executing either cpuid or wbinvd. 3. check that the
 kretprobe was hit with the right exit_code available in GHCB.
Message-ID: <YqD/ObG9ae9YQVNy@google.com>
References: <20220318094532.7023-1-vkarasulli@suse.de>
 <20220318094532.7023-3-vkarasulli@suse.de>
 <Ykzrb1uyPZ2AKWos@google.com>
 <YqBivtMl74FGmz7r@vasant-suse>
 <YqCzy5Kngj+OgD2h@google.com>
 <YqDD/0IWnoMXEAWg@vasant-suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqDD/0IWnoMXEAWg@vasant-suse>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022, Vasant Karasulli wrote:
> On Mi 08-06-22 14:35:55, Sean Christopherson wrote:
> > On Wed, Jun 08, 2022, Vasant Karasulli wrote:
> > > On Mi 06-04-22 01:22:55, Sean Christopherson wrote:
> > > > > +	if (ret) {
> > > > > +		kunit_info(test, "Could not register kretprobe. Skipping.");
> > > > > +		goto out;
> > > > > +	}
> > > > > +
> > > > > +	test->priv = kunit_kzalloc(test, sizeof(u64), GFP_KERNEL);
> > > >
> > > > Allocating 8 bytes and storing the pointer an 8-byte field is rather pointless :-)
> > > >
> > >
> > > Actually it's necessary to allocate memory to test->priv before using according to
> > > https://www.kernel.org/doc/html/latest/dev-tools/kunit/tips.html
> >
> > If priv points at structure of some form, sure, but you're storing a simple value.
> 
> Yes, I agree. The reason it was done this way I guess is that type of priv is a
> void pointer and storing a u64 value results in a compiler warning:
> cast from pointer to integer of different size [-Wpointer-to-int-cast].

An intermediate cast to "unsigned long" should make that go away.
