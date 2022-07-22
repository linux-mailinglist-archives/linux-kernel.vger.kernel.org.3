Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3451357E6C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 20:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbiGVSo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 14:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbiGVSo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 14:44:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602BE87224
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:44:25 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id q16so5098759pgq.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 11:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VblPSJwsGw1h15CG7/mpL6Be/8K4U7PwJxhZSMHkihc=;
        b=qhNumpqTQJ3qzrc9XWsTpk6fgatE8thCrcvMtJUbu9+dY0RYujpQeSOv7TeEWgLd5W
         CPjC/VEoQPLT0myYm4U23K/ZeckmrTMXq7w1piLei/384vEKXk2Vy9Ddi0qsuKewT2en
         yZcVoL2bCQoo0urx4ZXQq5vIpAqENejz2P7WwAFGOfcBRwovR7gvy2O6D7cqmQAjUHfi
         jgmHAIZBXtnjAOKsIqCnHrvlzXvgSBTaUBR1CoKwgy5ph6panQc2W2sKEPSSHKtCTQxw
         IsRYkVTbc1ieVlP7bZy6Z9cRYOPysEs9HKxkZ6KV0wC8+C8NMOonq9K6Weo2Zv5nbkxm
         TYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VblPSJwsGw1h15CG7/mpL6Be/8K4U7PwJxhZSMHkihc=;
        b=LWxL3tFe0zRpSj3zC0uVwQGew8TaEkuV+v7511V6EVnsHM6GFOHYrPEWfi3iEdpOSH
         BAe6ZfTPpzxvyNVcKuq++lR6jpyR5WXuSI2TcyoRmR+M0lV1AMP3gSZ6ckhlTF8goVSE
         voqqESgVZTcjL40Hm1tGT+RTvkEU/D/2xG7mn0Y5YfvS13d/gzdzTcIq1lbGbejArkJi
         9XOGVh0Gdo+RZC8N0taHwubEK6oQ1/qM1lO0D7ip3s27Jv7DK3/3lTZZnRoBevofZ6mt
         Pn/BFveoaLxAGSqMo5LJ9u82fTCAtbqJYBpt0RzVyvfnrEgYSOLii2Vtz9U70xmGGr8p
         SK6w==
X-Gm-Message-State: AJIora8c0GXawXO9sinbnGtYAWjOAJ52pwqfXtsQoheTyls/jcskuXL3
        qOi/kyB7Mj2m9HhOIS0ZpHZVug==
X-Google-Smtp-Source: AGRyM1s0DwMv4dlY7qisCxwvVoAefqQ3GmkZjGOghmvkRFMKme/kTmNBNjs1eyiBa+RVukabt0ibnQ==
X-Received: by 2002:a63:6b0a:0:b0:40d:ffa6:85c5 with SMTP id g10-20020a636b0a000000b0040dffa685c5mr919609pgc.327.1658515464720;
        Fri, 22 Jul 2022 11:44:24 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id k11-20020a170902c40b00b0016c97d59f6asm4214477plk.93.2022.07.22.11.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 11:44:23 -0700 (PDT)
Date:   Fri, 22 Jul 2022 18:44:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kai Huang <kai.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Haitao Huang <haitao.huang@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Message-ID: <YtrwA9XtuLMoAv4M@google.com>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
 <ab467244dd03b5f94bafe9068b1c02790033c18c.camel@intel.com>
 <a82e840f-2030-7ab3-7160-f1b900ecdb7d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a82e840f-2030-7ab3-7160-f1b900ecdb7d@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2022, Dave Hansen wrote:
> On 7/22/22 06:26, Kai Huang wrote:
> > Did a quick look at the spec.  It appears ENCLU[EDECCSSA] should be used
> > together with AEX-notify.  So besides advertising the new
> > SGX_ATTR_ASYNC_EXIT_NOTIFY bit to the KVM guest, I think we should also
> > advertise the ENCLU[EDECCSSA] support in guest's CPUID, like below (untested)?
> 
> Sounds like a great follow-on patch!  It doesn't seem truly functionally
> required from the spec:
> 
> > EDECCSSA is a new Intel SGX user leaf function
> > (ENCLU[EDECCSSA]) that can facilitate AEX notification handling...

Yeah, it's enumerated separately.

> If that's wrong or imprecise, I'd love to hear more about it and also
> about how the spec will be updated.
> 
> Oh, and the one-liner patch that I was promised for enabling this is
> getting a _wee_ bit longer than one line.

Heh, fool me once... 
