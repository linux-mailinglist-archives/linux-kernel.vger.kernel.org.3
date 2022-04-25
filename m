Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7514E50DD43
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbiDYJzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 05:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239076AbiDYJzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:55:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B373EBBB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:52:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650880321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lHewPGOCH7DwUdjYSxZy4n2P/phYOzvYXBI/OdB/YwM=;
        b=IbIU1Rs570h7WAP6wW82V7MoVtPof0Cs7e8+AXCPeEKCX8ozeqnN7sS3qanMiEAuRFOYFA
        9Yjd9bT+TwA1pTEZCTA5rqai0rPH+Ladp7QEKOkA9KsJRYiLMPI1BDBw/pEUPCTIxEW6cD
        TbiLLI++uTr5lJDphEustbde+i/zF3BpNkEsg+WPeVWrMc7rz2+7KpCkejuKQMv/eBqkQP
        yp6dTv9ZTmg0esIL52ELyprGdNNf48jedqT2ly8398GotxrhE+My86AZjbqqoN35rjcp2+
        9wwN73WZS9opn48WgRGDjQWhqikUjRjggJ3+G+6J5GcpTeJa0qqpZval5f8n6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650880321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lHewPGOCH7DwUdjYSxZy4n2P/phYOzvYXBI/OdB/YwM=;
        b=K7dKCqp14NXGaG7YO94e6oXYOIZjOE9geoNp5/X4F49F7dACl/rXofsDr5sdoEggxEf2oK
        9xJgjnofCdzYasDg==
To:     Donghai Qiao <dqiao@redhat.com>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, arnd@arndb.de, peterz@infradead.org,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, gor@linux.ibm.com
Cc:     donghai.w.qiao@gmail.com, linux-kernel@vger.kernel.org,
        Donghai Qiao <dqiao@redhat.com>
Subject: Re: [PATCH v2 01/11] smp: consolidate the structure definitions to
 smp.h
In-Reply-To: <20220422200040.93813-2-dqiao@redhat.com>
References: <20220422200040.93813-1-dqiao@redhat.com>
 <20220422200040.93813-2-dqiao@redhat.com>
Date:   Mon, 25 Apr 2022 11:52:00 +0200
Message-ID: <87a6c932yn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22 2022 at 16:00, Donghai Qiao wrote:
> Move the structure definitions from kernel/smp.c to
> include/linux/smp.h

...

> +static char *seq_type[] = {
> +	[CFD_SEQ_QUEUE]		= "queue",
> +	[CFD_SEQ_IPI]		= "ipi",
> +	[CFD_SEQ_NOIPI]		= "noipi",
> +	[CFD_SEQ_PING]		= "ping",
> +	[CFD_SEQ_PINGED]	= "pinged",
> +	[CFD_SEQ_HANDLE]	= "handle",
> +	[CFD_SEQ_DEQUEUE]	= "dequeue (src CPU 0 == empty)",
> +	[CFD_SEQ_IDLE]		= "idle",
> +	[CFD_SEQ_GOTIPI]	= "gotipi",
> +	[CFD_SEQ_HDLEND]	= "hdlend (src CPU 0 == early)",
> +};

How does this qualify as a structure definition?

Thanks,

        tglx
