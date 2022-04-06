Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373B04F57AD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbiDFHQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 03:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243310AbiDFHKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 03:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9EA7620E97C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 22:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649223176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8vMGwr2ZcpnAe+eNPSJFFMadFeqT5aD2vndagjKbi2A=;
        b=Vl0a1vwBsF7MEOnH9qLsE2wwFZhVzb8Qj0WH/nwe/sChkEXTCyviouxOsgLUSly9hvgO1h
        I7TnjY7NAbrlnWcnOqTlAAVYI0GmW+xLnoOhZTIdyh+fsZf94BcxUq6xx+CD9ell1Ortxu
        P1Sf7dBGOypFDeYxdnwfmkcgSFPOiIA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-63jZbRanNkSXXD0y9eZKSg-1; Wed, 06 Apr 2022 01:32:55 -0400
X-MC-Unique: 63jZbRanNkSXXD0y9eZKSg-1
Received: by mail-qt1-f198.google.com with SMTP id f3-20020ac84983000000b002e22396acfbso1656108qtq.18
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 22:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8vMGwr2ZcpnAe+eNPSJFFMadFeqT5aD2vndagjKbi2A=;
        b=GMaQ3ctlZOXxEJQFm/swxLyI2JBtmrvs/D6ud34a4Oj/2Kk7Yi62a65ul9CRIctU9Y
         bVySKS1CAOkdYgi52/M/RJzpbHluo/s3run51Vjc+1I6VIMMuphAxoUYN3TDtQfhPRJu
         YZy2MyO8PaPZp1j+uQ7Q02Ig2n3tslWZgxSfXfO6f6KY1rH4EIRifh3SCietL8U8HQ10
         OKlX6o302b+IJgxNSPrIq+Op2b8iqT0T2Sv+vAAF4viS7U+MmZU5/NuCev4GO5IzXa6L
         6cGBIYSserkB+Gau/J6lE6YIEvHMQn3DQIVVviZP9dLgN7cB1p/zCUlM2dS9K0oTn56N
         NSzg==
X-Gm-Message-State: AOAM532ggjCl/Er5X/gD2LRIVUIdbsoPdy1aYNvPOTJopO7VNfiRXl9n
        j/w2+T5SBLOGwPN6LylsJfqJYEGEWjENprkQ6E4Rh5W/8dhA32iKVPwSrgG9PpgydKexPWw2S7L
        IfNiUbpAPDAwZraLN7vi96l2m
X-Received: by 2002:a05:6214:5008:b0:441:547c:e75e with SMTP id jo8-20020a056214500800b00441547ce75emr6091251qvb.128.1649223174856;
        Tue, 05 Apr 2022 22:32:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDArzZsQST0q35Psaq4DH2TN0zwJqYR+LAkTq39xUbLh8CQFRzGFwbSET5A9m07rkkXPDZ9g==
X-Received: by 2002:a05:6214:5008:b0:441:547c:e75e with SMTP id jo8-20020a056214500800b00441547ce75emr6091238qvb.128.1649223174611;
        Tue, 05 Apr 2022 22:32:54 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id a23-20020a05620a16d700b0067e98304705sm8755689qkn.89.2022.04.05.22.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 22:32:54 -0700 (PDT)
Date:   Tue, 5 Apr 2022 22:32:51 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
Message-ID: <20220406053251.6dyfxrjmmgdwocfc@treble>
References: <202204041241.Hw855BWm-lkp@intel.com>
 <YkxLqznOz0ldTz5a@hirez.programming.kicks-ass.net>
 <20220406000500.5hlaqy5zrdqsg5mg@treble>
 <87czhv11k1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87czhv11k1.ffs@tglx>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 02:46:22AM +0200, Thomas Gleixner wrote:
> On Tue, Apr 05 2022 at 17:05, Josh Poimboeuf wrote:
> > On Tue, Apr 05, 2022 at 04:01:15PM +0200, Peter Zijlstra wrote:
> >
> > But objtool is complaining about a real problem (albeit with a cryptic
> > warning).  I don't think we want to paper over that. See patch.
> >
> > Also, are in-tree users of trace_printk() even allowed??
> 
> See the comment in the header file you are patching:
> 
>  * This is intended as a debugging tool for the developer only.
>  * Please refrain from leaving trace_printks scattered around in
>  * your code. (Extra memory is used for special buffers that are
>  * allocated when trace_printk() is used.)

So what do we do ... send a nastygram?  

> > +	__ip = _THIS_IP_;						\
> >  	if (__builtin_constant_p(fmt))					\
> > -		__trace_bprintk(_THIS_IP_, trace_printk_fmt, ##args);	\
> > +		__trace_bprintk(__ip, trace_printk_fmt, ##args);	\
> >  	else								\
> > -		__trace_printk(_THIS_IP_, fmt, ##args);			\
> > +		__trace_printk(__ip, fmt, ##args);			\
> >  } while (0)
> >  
> >  extern __printf(2, 3)
> 
> This covers the trace_printk() case which uses do_trace_printk(), but
> the same problem exists in trace_puts() and ftrace_vprintk()...., no?

Yes, though objtool didn't seem to complain about those yet.  They
probably don't have the perfect storm required for the label to end up
at the end of the function.  It might also need something like being
invoked from within a macro which then does BUG() (see GEM_BUG_ON).

More broadly, this issue could theoretically happen in some other places
throughout the kernel tree, since _THIS_IP_ is fundamentally unreliable
as currently written.

So we could look at making _THIS_IP_ more predictable.

Inline asm would work better ("lea 0(%rip), %[rip]"), but then you need
an arch-dependent implementation...

Or we could add a control dependency like the below ugliness...

Thoughts?


diff --git a/include/linux/instruction_pointer.h b/include/linux/instruction_pointer.h
index cda1f706eaeb..3f2f0ebecca0 100644
--- a/include/linux/instruction_pointer.h
+++ b/include/linux/instruction_pointer.h
@@ -2,7 +2,9 @@
 #ifndef _LINUX_INSTRUCTION_POINTER_H
 #define _LINUX_INSTRUCTION_POINTER_H
 
+unsigned long __this_ip(void);
+
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
-#define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
+#define _THIS_IP_  __this_ip()
 
 #endif /* _LINUX_INSTRUCTION_POINTER_H */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index da03c15ecc89..8674c7434ead 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3781,3 +3781,8 @@ void __printk_cpu_unlock(void)
 }
 EXPORT_SYMBOL(__printk_cpu_unlock);
 #endif /* CONFIG_SMP */
+
+unsigned long __this_ip(void)
+{
+	return _RET_IP_;
+}

