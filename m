Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3BF58CA11
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 16:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiHHOCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 10:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiHHOCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 10:02:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD56B7E9
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 07:01:59 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659967317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAuPasQJR1qgXtwI72yzz6F0nQC/FTbsBx4YgG+wgS4=;
        b=zpIYZaRYj0gl1Scsc4nqCkSnBKB8ZxoX+2534wNO5IiPMLj+S7O4YNTkGwGLehPLpcIDsK
        eQpN5EMP8hUXr3pQp40s56kYpCpXyDfpgZZJW6b3uSVQpHeQomVGfR3E930WnT2z35ObIA
        A6+g/evNu0Cotqqa2KNMDlp9fVZCMrTTZbrZaco/7xxzmb/r/C0ksV/G7JC+wTEICTXfwx
        6dYaJxFK4eWrbWqCSYQmVCMQuDPklNxbu6w5FOhm4KzVp+dBJUVtm7tlN7kG3/oDw4kY1d
        GA22SXc4GBNDHfsw3f9SWFTKJ3OZFk7d13Aj/RtR/cNMOFB2IooTNdsD5O9Xvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659967317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gAuPasQJR1qgXtwI72yzz6F0nQC/FTbsBx4YgG+wgS4=;
        b=x8qziAUPZReT4VqdSujf3VMv0Sq2nSqjH0HNPh3M3kkJArXiwgpKlGw7CeQHd8YtlTOSjB
        t7v3N0iIf+7Xw4Bw==
To:     Duoming Zhou <duoming@zju.edu.cn>, linux-kernel@vger.kernel.org
Cc:     jstultz@google.com, sboyd@kernel.org, edumazet@google.com,
        Duoming Zhou <duoming@zju.edu.cn>
Subject: Re: [PATCH] timers: fix synchronization rules in comments of
 del_timer_sync
In-Reply-To: <20220701085535.17018-1-duoming@zju.edu.cn>
References: <20220701085535.17018-1-duoming@zju.edu.cn>
Date:   Mon, 08 Aug 2022 16:01:57 +0200
Message-ID: <877d3irfze.ffs@tglx>
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

On Fri, Jul 01 2022 at 16:55, Duoming Zhou wrote:
> - * Synchronization rules: Callers must prevent restarting of the timer,
> - * otherwise this function is meaningless. It must not be called from
> - * interrupt contexts unless the timer is an irqsafe one. The caller must
> - * not hold locks which would prevent completion of the timer's
> - * handler. The timer's handler must not call add_timer_on(). Upon exit the
> - * timer is not queued and the handler is not running on any CPU.
> + * Synchronization rules: Callers must prevent restarting of the timer in
> + * other places except for the timer's handler, otherwise this function is
> + * meaningless. It must not be called from interrupt contexts unless the
> + * timer is an irqsafe one. The caller must not hold locks which would
> + * prevent completion of the timer's handler. The timer's handler must
> + * not call add_timer_on().

If we are making this correct: What's so special about add_timer_on()?

Thanks,

        tglx
