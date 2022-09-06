Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBD85AF027
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiIFQRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiIFQRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:17:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C8B6E2C5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662479143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UwR9WLlMcOlcjIJvL6VN4UAUczzjG6l4ky/hbJluh+s=;
        b=W7E+QJrQftbjpgvvaywk0+3JdPW/GV5mKyaq7LHGx9JGRB4dWWCGIS2yju6KKam7lsydzd
        amoVTWU0Haek8tQ6DtJ3Hn/UiLS2yzE+cKGi//x2cYjN8YsJAEEBgzRok2tjH//Y/dio8j
        Pg5KVUQOPnFrafnUGRLpB5qkdvilzA4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-497-lEm8pABVPCWW_M_SGjRtWw-1; Tue, 06 Sep 2022 11:45:41 -0400
X-MC-Unique: lEm8pABVPCWW_M_SGjRtWw-1
Received: by mail-wm1-f69.google.com with SMTP id 203-20020a1c02d4000000b003a5f5bce876so8958613wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 08:45:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=UwR9WLlMcOlcjIJvL6VN4UAUczzjG6l4ky/hbJluh+s=;
        b=D8yO68fVN66b5wbykJt79Rngcm20FJl29mW0ZgdxT+JazHjBe8JrsbBgMlGMR7ZoO+
         2QyANDMk0NsziZxyU4pQFTch1UBbYhdSHUHaTvkTxh+T/gt/ff9wFap/CoC1OVuEaFBh
         X9HpNIfHIbFqaAxfsseKDE1KdaAEWc42HErkBZxzaJxLNGEUHbnmNXKmDJuNJPk4Cza1
         yrQBB0Gr/i7yVJUFQngo0GKnG0bS/jc3FaV4WV2QfpN7yhhgbmP1b0VvzJ8B8uXBi7zX
         0lA6i/nh7cULAlIkJpyDfSgOdWBV/+NpA8Y+OBKyAt/PplWogDZPLTqUGl6Z+CHYPTtr
         dgNg==
X-Gm-Message-State: ACgBeo3KhM2z46OAopZvDRqG3dBl7fMMQOAfPcBwNQXuiFs6ca1UZQdg
        y91wAiRPzJ9h/GQSlYT++MX2y+gSb5UESRz6o/++/Ra9sIsLgyCH0AeDCVNQCWwDUEjxCsah7ys
        l1iezoliOW6+Ok9KcY5KbfoHv
X-Received: by 2002:adf:d1e8:0:b0:223:bca:8019 with SMTP id g8-20020adfd1e8000000b002230bca8019mr27334461wrd.562.1662479139553;
        Tue, 06 Sep 2022 08:45:39 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5koLA8Nh5T8MSFtHiXTikfjA2tCMg2n1xwQ9omsbDczQllbiS5uHpSlqayh1h9C3PKVbLPoQ==
X-Received: by 2002:adf:d1e8:0:b0:223:bca:8019 with SMTP id g8-20020adfd1e8000000b002230bca8019mr27334451wrd.562.1662479139408;
        Tue, 06 Sep 2022 08:45:39 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id v22-20020a7bcb56000000b003a5ad7f6de2sm15138039wmj.15.2022.09.06.08.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 08:45:38 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 0/5] cpumask: cleanup nr_cpu_ids vs nr_cpumask_bits mess
In-Reply-To: <YxdbaWaO8lWWqT9q@hirez.programming.kicks-ass.net>
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <YxcK+HXLQ8WBS9Ee@hirez.programming.kicks-ass.net>
 <xhsmhy1uwbtbc.mognet@vschneid.remote.csb>
 <YxdbaWaO8lWWqT9q@hirez.programming.kicks-ass.net>
Date:   Tue, 06 Sep 2022 16:45:37 +0100
Message-ID: <xhsmhv8q0bj6m.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/22 16:38, Peter Zijlstra wrote:
> On Tue, Sep 06, 2022 at 01:06:47PM +0100, Valentin Schneider wrote:
>
>>   #define nr_cpumask_bits nr_cpu_ids
>
> That assumes the CPU space is dense; is this so? That is, you can have 4
> CPUs while the highest cpu number is vastly larger than 4.
>
> It's uncommon, but not unheard of I think. ISTR some BIOSes leaving
> holes in the CPU space when there were empty CPU sockets on the
> motherboard.

I'd assume this would be visible in the cpu_possible_mask and thus be
properly reflected in nr_cpu_ids. Otherwise that would already break with
CONFIG_CPUMASK_OFFSTACK=y, I think.

