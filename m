Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16B756BC90
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 17:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238286AbiGHOj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbiGHOj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:39:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F80813F0D;
        Fri,  8 Jul 2022 07:39:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 189966285E;
        Fri,  8 Jul 2022 14:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACFD4C341C6;
        Fri,  8 Jul 2022 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657291194;
        bh=n9Wx6YYU0Hw39VR6mkEgQaCtA6WpxtO3+AJlLEHoUFA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZSY/ZLBvJ/J3h/RRCHua4mwZbteQKzhRzR3P5WkJBs5pXv4cELtRWn62w3jwr+GWG
         wAx/XR6l//C3n6/+A6+LBVv/D9xLWKh0i+caBBV4fcwtvfS5BHiH5vmsvb/2gkfmFx
         JkS6E/KOOEfDVM3g6Vo1Zrh3hj6s39Xq3o3ymn4/DTe+EljcU/wngqdfSzPfTVjW+a
         DRHETPi08dBezjX/0b1j+5tULfEDgPQJP4IFOKiwdNNA6ulRLvYH8OQn75iIbKgiP+
         oRM66EcHFeHqdJqEaD15nssvuRip1jVFp11Lblg6mKoRbN6K9Y/BoQLWcBGwuh54rj
         KrLu3esqMfCog==
Message-ID: <adbf8277-e680-9357-950d-22cf54b1f6ff@kernel.org>
Date:   Fri, 8 Jul 2022 16:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 01/20] rv: Add Runtime Verification (RV) interface
Content-Language: en-US
To:     Tao Zhou <tao.zhou@linux.dev>, Steven Rostedt <rostedt@goodmis.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1655368610.git.bristot@kernel.org>
 <60548902dbccaa7ba420e40e46835693e27f643f.1655368610.git.bristot@kernel.org>
 <YsXLDvjHqOxYtckg@geo.homenetwork>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <YsXLDvjHqOxYtckg@geo.homenetwork>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Tao!

On 7/6/22 19:49, Tao Zhou wrote:
>> +static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
>> +{
>> +	struct rv_monitor_def *m_def;
>> +	loff_t l;
>> +
>> +	mutex_lock(&rv_interface_lock);
>> +	m_def = list_entry(&rv_monitors_list, struct rv_monitor_def, list);
> I realized this m_def is not real but vain. Is it possible the loop is
> skiped and just return m_def that is not valid.

that is empty... not a problem.

I am not seeing (the possible) problem here. Could you simulate/reproduce the problem?

Btw, this code is "inspired" (iow stolen) from trace_events.c.

Am I missing something? steve?

>> +	for (l = 0; l <= *pos; ) {
>> +		m_def = enabled_monitors_next(m, m_def, &l);
>> +		if (!m_def)
>> +			break;
>> +	}
>> +
>> +	return m_def;
>> +}

-- Daniel
