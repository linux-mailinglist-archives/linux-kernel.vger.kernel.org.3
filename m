Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC79517767
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387130AbiEBT22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387124AbiEBT2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:28:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F1010B2
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:24:47 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651519486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79FIQWgZ3h5gC5Jb6uCcF1+LUzlryhagoge6MP0eaxc=;
        b=WEoieK0bQvlqzf3gKgjbI2TuNtb3I80HtU7AB3beVMIj1nEsAVQhQdBKJPFoL5f95C6cKF
        UazawVrmlTpkX5ofUtyrIxAaixDHmdvL+i23qPeOtQP4ljr2yzModbJ8uhCuV8A0NDfN+h
        WplW+HYme0EajQ6t077V00iEG8C2jyKFXF5tlihS3zsFjnY790UscYQcgz6Ser7hgRDFns
        /nBgqpRMU4gIDoG8Uho976lTRg8/YrNXaPq3YOQ2sOQLBR+AOcAr+94RFGgI5387xbCjcZ
        E8nzrjaiwQtDbiTsjO9bbHJPIZuUIHy7s287Vq1ipQzxX2WMKynUo+VOrXTgMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651519486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=79FIQWgZ3h5gC5Jb6uCcF1+LUzlryhagoge6MP0eaxc=;
        b=wfohYVUJQZmODFbpKoI2GLYZqDMp9Axj+alNBfuYMI6FGDVfV/4PFSPAqlXWaobzwsFqbJ
        aLmwf9m/K8iOirAw==
To:     Hillf Danton <hdanton@sina.com>
Cc:     Thomas Pfaff <tpfaff@pcs.com>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v3] irq/core: synchronize irq_thread startup
In-Reply-To: <20220502160106.4587-1-hdanton@sina.com>
References: <552fe7b4-9224-b183-bb87-a8f36d335690@pcs.com>
 <20220502160106.4587-1-hdanton@sina.com>
Date:   Mon, 02 May 2022 21:24:45 +0200
Message-ID: <877d73n3eq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03 2022 at 00:01, Hillf Danton wrote:
> On Mon, 02 May 2022 16:28:56 +0200 Thomas Gleixner  wrote:
> --- upstream/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1258,6 +1258,7 @@ static int irq_thread(void *data)
>  	struct irq_desc *desc = irq_to_desc(action->irq);
>  	irqreturn_t (*handler_fn)(struct irq_desc *desc,
>  			struct irqaction *action);
> +	bool waked = false;
>  
>  	sched_set_fifo(current);
>  
> @@ -1282,8 +1283,11 @@ static int irq_thread(void *data)
>  			irq_wake_secondary(desc, action);
>  
>  		wake_threads_waitq(desc);
> +		waked = true;
>  	}
>  
> +	if (!waked)
> +		wake_threads_waitq(desc);

That's a guarantee to make desc->threads_active go negative in the case
that the thread was never woken by a hard interrupt handler. IOW, you
created a new problem which did not exist before.

The problem discussed here is not a problem in irq_thread(), it's a
problem of not reaching this function in the first place. See the on
point analysis in Thomas Pfaffs patch.

Thanks,

        tglx

