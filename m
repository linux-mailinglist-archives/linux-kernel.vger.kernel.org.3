Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB49563E01
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 05:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbiGBD1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 23:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGBD1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 23:27:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DA637ABE;
        Fri,  1 Jul 2022 20:27:11 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b12-20020a17090a6acc00b001ec2b181c98so8192900pjm.4;
        Fri, 01 Jul 2022 20:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:to:cc:references:subject
         :content-language:from:in-reply-to:content-transfer-encoding;
        bh=s+6CTwYMp+CWbidlKsAY/mNC/AWdOdnbGcTllivcfjA=;
        b=i2Kyt4uH3b+JAcLn8a7wiqQbZz8NtDvdcE9A8I0SfgETxYhGlD9HjR3f8WzZ+UQj8x
         K3lxXr40wRe3+uql+mGBz9qRkA6ZRjd2uXjaP6tCfeCeHVuvdcAlCuWbqgQVMtZDicn2
         eH+Zqy9HAfhr0KUZ1SmT08qlkhFrzm3zz4z9ZpQ4rlYEBUNuZD85TBWRPhErZM4YW/oq
         gkNToj1+TxW4QAgGlZNyK6B+tjEym+2693hOWjEV7Snxynw9haZRvldOaTUEzU/elYFX
         Sd/mxYg9QNHq6z78QULQnPx0zBKRhpzgivL2ZLTn82KNnAbn0LIsrAp0DW0U1DlPFG09
         IzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:to:cc
         :references:subject:content-language:from:in-reply-to
         :content-transfer-encoding;
        bh=s+6CTwYMp+CWbidlKsAY/mNC/AWdOdnbGcTllivcfjA=;
        b=ntTTiMXuNU00fxAJ9BBr3q3C4Tqwkdclvj5zafWbpdVHQ2hZZYJSXI5cCQ/fuDlB+G
         ssnyGWm8Psfgqc8jBxrwloF7OUzYw+38f6pHtUeCwVCqCbaghqEM/tktMyTyrBl1kJoI
         Mgj4vgX9xdr5TJbvh9DLU93ZnZnsCAsD+ZPiE4/rd+sPWamdYfvruYCkB0YOFWMKa++O
         uVlLgvqICw0Pp7H4ThJNOvWLADY7IXFEYRioSKqBbQ0PVW10XFaVSG0YXOCmq50hQFbt
         XjWTGHs6hb1yO4SANsbO2+LgiisXij8yMR2ENQJ5JNSyGp3VMgpUGu4kAj8HwyfSDmVR
         f0gw==
X-Gm-Message-State: AJIora/BNDgiXYuEKa/UUVcXPKq4gcni6a7Fzt0+0uCkdDeCOSIBvt3k
        U2w+TEIHRz15npUof4XTHBKuhnFs5R0=
X-Google-Smtp-Source: AGRyM1vT5WTMrlTJS6hab7FTm7WO0xCZPP4jsuY2oGhNh1ECKzASR8K2HH3vEu89zCeHtaQqDlN2gA==
X-Received: by 2002:a17:902:ecd0:b0:16a:2c0f:3a1a with SMTP id a16-20020a170902ecd000b0016a2c0f3a1amr23488518plh.108.1656732431470;
        Fri, 01 Jul 2022 20:27:11 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id y67-20020a626446000000b0051bd9981cacsm16437368pfb.123.2022.07.01.20.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 20:27:10 -0700 (PDT)
Message-ID: <44dd52ee-bf53-ba66-da82-0a90402812a1@gmail.com>
Date:   Sat, 2 Jul 2022 12:27:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        n@nfraprado.net
References: <20220630163630.714673-1-corbet@lwn.net>
Subject: Re: [PATCH 0/2] docs: A couple of automarkup improvements
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20220630163630.714673-1-corbet@lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jun 2022 10:36:28 -0600, Jonathan Corbet wrote:
> Building the docs takes far too long.  Much of the blame for that lies with
> Sphinx, but some of it is under our own control.  These two patches
> eliminate a bunch of useless work in the automarkup extension.
> 
> Benchmarking Sphinx runs is hard, as the run time can be rather variable.
> I have consistently found about a 15% speedup from these patches, though,
> with no output changes.
> 
> Testing was done with Sphinx 4.4.0 and 5.0.2.  My systems all have Python
> 3.10 installed, and there does not appear, alas, to be a straightforward
> way to get Sphinx 3.x to run on that version.  Versions of Sphinx prior to
> 3.0 will not be affected by these changes.

They look nice improvements, indeed!

On my rather non-performant machine with Python 3.9.2 + Sphinx 5.0.2,
elapsed time of "make htmldocs" decreased about 12% without any difference
in generated HTML files.

For the series:

Tested-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira
> 
> Jonathan Corbet (2):
>   docs: automarkup: track failed cross-reference attempts
>   docs: automarkup: do not look up symbols twice
> 
>  Documentation/sphinx/automarkup.py | 56 +++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 24 deletions(-)
> 
> -- 
> 2.36.1

