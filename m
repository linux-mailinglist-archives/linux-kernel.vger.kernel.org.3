Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BABB4F691D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 20:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239952AbiDFSDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 14:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240163AbiDFSCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 14:02:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E997921593E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649263029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wFhqU92i2F2z0WXuiDLML34olBedCCl24eMXRkDAOvo=;
        b=QlBODx/X9CZL1SFZCE0J41YlrJm/0XAJHEZUeLmxniY3MPa9j7ROOL0fIreBV0iv6P1a66
        vu2mliTqD/09Dihwqyn9Y52h4LVPBDm+XUqx1MNNk9aKHDqLqyfMnpJZPVs3ITLnPn0DYM
        bIs0/LY03Ix0ZHEn0uvMo0ewQEragWA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-eGnFJhV1OcmfLwh7wIwl4w-1; Wed, 06 Apr 2022 12:37:08 -0400
X-MC-Unique: eGnFJhV1OcmfLwh7wIwl4w-1
Received: by mail-qt1-f197.google.com with SMTP id h11-20020a05622a170b00b002e0769b9018so3405232qtk.14
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:37:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wFhqU92i2F2z0WXuiDLML34olBedCCl24eMXRkDAOvo=;
        b=bdUmdM0YFfPWS22XTyVcE4rhOxflYVUCQaxemrU1VUdN5axOmXPyFNC8CudDK/zTXJ
         8lGBxwP9Ol99B47NetRnAKlnxLWwlEsAu8cGW+8OGisT1y8uaMWr1zutuYp8We8kLfua
         Tk6pjEAjxAUX2H2iHjGt/DfG7hfSovZEoOcDuDOZqNxNDqFvyBoa2ERbTq64xIfRHR/l
         VOTTy+zS7MVs98MHqNrHfxLD2EWmAFi4cqMw/IeGac37A7CCubMI3EROcI1uvrsyEj0L
         0jU+nYMur/voIe8gW2ETHujrq0SdKzPt3EWHdNtYw6osVrZwCA2uKj7q44t4+eHY49VS
         HMcA==
X-Gm-Message-State: AOAM531QuHkFYO8ML2CtyvxNmXN/7kMgoqVKuewaI/cfpBP30IE1DeTF
        Q/XhifMlFQNlsyFjdtvvalpgRMgHnv6Yt1hue+9uCntZ2/zEUBtGoc5A4bOfSVoMb/edzkAdbzs
        ph5UwPwKlPXJjImerTANsv+bo
X-Received: by 2002:ac8:5944:0:b0:2e2:e4b:f4b6 with SMTP id 4-20020ac85944000000b002e20e4bf4b6mr8237199qtz.89.1649263027693;
        Wed, 06 Apr 2022 09:37:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyKGgJPnSloLlwQDmxsXUcDo9JBRUcAOHDi9Zwg8EcQv4I6Ns6POfnDnMyPrNP5djs+1pj2xA==
X-Received: by 2002:ac8:5944:0:b0:2e2:e4b:f4b6 with SMTP id 4-20020ac85944000000b002e20e4bf4b6mr8237181qtz.89.1649263027461;
        Wed, 06 Apr 2022 09:37:07 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id t72-20020a37464b000000b0067ec1c9dcaesm10160791qka.44.2022.04.06.09.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:37:07 -0700 (PDT)
Date:   Wed, 6 Apr 2022 09:37:03 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
Message-ID: <20220406163703.hhet4ai7ztd7g4j4@treble>
References: <202204041241.Hw855BWm-lkp@intel.com>
 <YkxLqznOz0ldTz5a@hirez.programming.kicks-ass.net>
 <20220406000500.5hlaqy5zrdqsg5mg@treble>
 <87czhv11k1.ffs@tglx>
 <20220406053251.6dyfxrjmmgdwocfc@treble>
 <20220406074330.GD34954@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220406074330.GD34954@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 09:43:30AM +0200, Peter Zijlstra wrote:
> On Tue, Apr 05, 2022 at 10:32:51PM -0700, Josh Poimboeuf wrote:
> > More broadly, this issue could theoretically happen in some other places
> > throughout the kernel tree, since _THIS_IP_ is fundamentally unreliable
> > as currently written.
> > 
> > So we could look at making _THIS_IP_ more predictable.
> > 
> > Inline asm would work better ("lea 0(%rip), %[rip]"), but then you need
> > an arch-dependent implementation...
> 
> Well, there's a ton of _THIS_IP_ instances all around, and it would be
> unfortunate to have them grow into actual code :/

What do you mean by growing into actual code?  It's still just a single
instruction, as was the immediate load before.

Though, you pasted this on irc:

  #define _THIS_IP_  ({ __label__ __here; __here: asm_volatile_goto ("":::: __here); (unsigned long)&&__here; })

which seems decent to me, though less than ideal because it grows an
ENDBR.  But I like its arch-independence, so yeah, LGTM.

-- 
Josh

