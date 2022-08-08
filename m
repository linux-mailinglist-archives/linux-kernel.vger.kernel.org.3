Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A9658C717
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242137AbiHHLDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbiHHLD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:03:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C341555B8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 04:03:28 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id r4so10796380edi.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 04:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jE7rDzDJl54ngSeDSzix1uvFy6MwH/Sd6J9jXSbtUjE=;
        b=jOeH74/bjd+f49sRgyezy7cILVoSDE6hWrGLBmU8FhuyWct9gaEdqyi62ahrDhXyUY
         P+niYKnvQCnOJZluZ4D6WSbGqN/8Jin+1P4yZ6x+29OnP72ghuUx+NCI0zIMIMdpR2Q4
         mBAK44TczmFLT8HMVzC4lWZu50/0UYVMXGEqy2KkgEInFjDEdHbyZ8SrwCgFXlXO1vbf
         WLbhTMPeV7dg//pLx07m3PqeEwSQ7pBXucII4jxufMMjuJk73Pg2HcetCxHvPWHHREc+
         4vuVvcUgWtmPPybvD76iwXqf0hZzZhuslcotwFRXhw/KEanZyvKBGPG6WgUdPn/uVWf3
         5oHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jE7rDzDJl54ngSeDSzix1uvFy6MwH/Sd6J9jXSbtUjE=;
        b=BEo7sBkJ/YZAywBXd7un/wlHNvIq16y7NDA4Gt+aNnvdzgzZPqk19uIOQOR1Y9t7Kf
         ExXoUYk8daq8nl2A+LSewNyNsDhfFsvzInyGyRN5Y3ZGDYKGn0LsKel+U+TCZLjFQIcu
         iPIldqkgR+W+ZQQlxi7SlI2Qfd7jKJ8LwTfRQpxrWla38EdXiT5JMb/JkNlpBJBHPpPs
         ZTL9kKz1LRrNzhAZhYBhdPSZOxxc24y5fprZSDRtTYr4AB739dSsfAwGNtHNaZVc9nvt
         h3SO8wqnWpx8bt1eE20p7IVgm9vv6OzeH8w9Fu94BbfEFhoqvRiSaVnmJV//7fDuAtPd
         whgQ==
X-Gm-Message-State: ACgBeo01gTEAO6AUIuKzE0bdAMKh3EXLaPVmQCS5OdtjU7XksuqhIdI3
        LIF7cbBnkeOex0xbyPW1IsQ=
X-Google-Smtp-Source: AA6agR7hLYLbwUWRobu85SHEDU/sKF/rBIBgRcg6Hy0KWFYYDR55eB6dnwOsJ2K8zBJ2I2gLHarSQw==
X-Received: by 2002:aa7:cc13:0:b0:43d:4c1:3806 with SMTP id q19-20020aa7cc13000000b0043d04c13806mr17121364edt.129.1659956607282;
        Mon, 08 Aug 2022 04:03:27 -0700 (PDT)
Received: from gmail.com (195-38-112-141.pool.digikabel.hu. [195.38.112.141])
        by smtp.gmail.com with ESMTPSA id jw16-20020a170906e95000b00726298147b1sm4815522ejb.161.2022.08.08.04.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 04:03:26 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 8 Aug 2022 13:03:24 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ira Weiny <ira.weiny@intel.com>, Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Rik van Riel <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [RFC PATCH 5/5] x86/entry: Store CPU info on exception entry
Message-ID: <YvDtfKRyMGenRMU5@gmail.com>
References: <20220805173009.3128098-1-ira.weiny@intel.com>
 <20220805173009.3128098-6-ira.weiny@intel.com>
 <5d62c1d0-7425-d5bb-ecb5-1dc3b4d7d245@intel.com>
 <Yu4t0jkpIY4grgxL@gmail.com>
 <Yu4wON0MRGH7h5Jv@zn.tnic>
 <Yu+Nwbn4CZUmyD14@gmail.com>
 <Yu+VV8xFTYRh0D0a@zn.tnic>
 <YvAaXet3sBg3mRDe@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvAaXet3sBg3mRDe@iweiny-desk3>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ira Weiny <ira.weiny@intel.com> wrote:

> On Sun, Aug 07, 2022 at 12:35:03PM +0200, Borislav Petkov wrote:
> > On Sun, Aug 07, 2022 at 12:02:41PM +0200, Ingo Molnar wrote:
> > > * Borislav Petkov <bp@alien8.de> wrote:
> > > > With the amount of logical cores ever increasing and how CPU packages
> > > > (nodes, L3 sharing, you name it) get more and more complex topology,
> > > > I'd say the 2 insns to show the CPU number in every exception is a good
> > > > thing to do.
> > > 
> > > We can show it - I'm arguing against extracting it too early, which costs
> > 
> > Not early - more correct. We can say which CPU executed the exception
> > handler *exactly*. Not which CPU executed the exception handler *maybe*.
> > 
> > > us 2 instructions in the exception fast path
> > 
> > 2 insns? They don't matter at all. FWIW, they'll pull in the per-CPU
> > cacheline earlier which should be a net win later, for code which does
> > smp_processor_id().

I'd like to hear what Andy Lutomirski thinks about the notion that
"2 instructions don't matter at all" ...

Especially since it's now 4 instructions:

> I agree with Boris; however I feel that I have to mention that in patch 
> 3/5 you also have 1 instruction on each of entry and exit to push the 
> extra stack space.  So all told it would cost 4 instructions.

... 4 instructions in the exception path is a non-trivial impact.

> Again, I don't believe this is too much overhead but I don't want people 
> to say it was not discussed.

Is it necessary to do this, what are the alternatives, can this overhead be 
avoided?

Thanks,

	Ingo
