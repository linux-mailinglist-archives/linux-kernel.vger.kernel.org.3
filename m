Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0BB57B96D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241271AbiGTPU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241278AbiGTPUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:20:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3252B628;
        Wed, 20 Jul 2022 08:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FFD6B81FB7;
        Wed, 20 Jul 2022 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B08EAC3411E;
        Wed, 20 Jul 2022 15:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658330421;
        bh=x+cgZ5X4Ep6UEjkiKUNBhV2MCaTDdeS8opcNoRCBkPQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kMJby8dWE+VITkxrQy8XmXzRWixu18hn9Nt74JIRL1LXwGU2NbGBwjHXO2YR8ZRuc
         H8t6g+7sZf6Wuta863wg9ChmuS5Ftf0l9VcKdPbkHPkGU2pxItBTvcPpS849moKAQs
         NZGOnxy3z14U2cCbl85eK9nHEUOy8sZiM3coyKi70R2Q2ZxC0KTDaZr+VqLs4nSzQd
         J6lIiUcy0nCQ9vnx4TVxgEZ4kkdHTXTEaR1YrKnI9A1iBkuDfaF+Qsr6gwxo0KALJg
         GfcSnALGxNY5QZ0goteRjarX8qCXgmn7WAv5Me4AzHjQsv2Yqa0DAYAcsvVZl+k/9b
         olRVUvLAhNPBw==
Message-ID: <311a6ac0-98c0-708f-1866-fcfc6c5e90f2@kernel.org>
Date:   Wed, 20 Jul 2022 17:20:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V6 01/16] rv: Add Runtime Verification (RV) interface
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
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
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
References: <cover.1658244826.git.bristot@kernel.org>
 <69bb4c369b4f6f12014eb9ca3c28b74e4378c007.1658244826.git.bristot@kernel.org>
 <20220720104718.59148968@gandalf.local.home>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20220720104718.59148968@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 16:47, Steven Rostedt wrote:
> On Tue, 19 Jul 2022 19:27:06 +0200
> Daniel Bristot de Oliveira <bristot@kernel.org> wrote:
> 
>> +/*
>> + * Interface to read the enable/disable status of a monitor.
>> + */
>> +static ssize_t monitor_desc_read_data(struct file *filp, char __user *user_buf, size_t count,
>> +				      loff_t *ppos)
>> +{
>> +	struct rv_monitor_def *mdef = filp->private_data;
>> +	char buff[256];
>> +
>> +	memset(buff, 0, sizeof(buff));
>> +
>> +	mutex_lock(&rv_interface_lock);
>> +	snprintf(buff, sizeof(buff), "%s\n", mdef->monitor->description);
>> +	mutex_unlock(&rv_interface_lock);
> 
> What exactly is the mutex protecting here?

I placed it around all access on read/write in the interface,
but indeed, it is not needed here (static data). It is in a file inside
the monitor's directory... so the directory is there, and the
module is there as well.

-- Daniel
