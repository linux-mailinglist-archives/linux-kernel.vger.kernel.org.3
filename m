Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899914E618D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 11:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349438AbiCXKNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 06:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346197AbiCXKNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 06:13:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C659AA0BC1;
        Thu, 24 Mar 2022 03:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2rIZVS6EvRV9sItE09wtI9+COSxwzJ5TyWlpN0L/jxo=; b=CPJ6NbGKHXAcdSgJMmQ7Lqssdg
        Et3Hvto8yJlXyVgHoCpgNq5W+ZNviPdcIk5Spfkj+yysp/f6G0BW8H0EiD4HIFywzrP8AH+/g8Kin
        JJSK3g467SflQNSDbrM67BEKUip6oly29jmt1ALjBzgasAbtgKwKgXVpWw6iy7WrJMKO9CZbALUL4
        +lfpsxTjOeVIhGGSQZDCXYoDRkC9k1Gbw6I1lgnrLjGgEfkly7KFTsCqym3iRO4u/MUH2VZypsGEL
        sItMYZUALwq3ObI8BgV4R6MQ0HZt7uEcppugH4Hv27GSllniLkOW+vAu92xm6fLR/V7d2+Da3WAqn
        3i5btjdA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXKQu-0042w8-0k; Thu, 24 Mar 2022 10:11:08 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3F48986201; Thu, 24 Mar 2022 11:11:07 +0100 (CET)
Date:   Thu, 24 Mar 2022 11:11:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86: Unify format of events sysfs show
Message-ID: <20220324101107.GC8939@worktop.programming.kicks-ass.net>
References: <20220324031957.135595-1-yangjihong1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324031957.135595-1-yangjihong1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 11:19:57AM +0800, Yang Jihong wrote:
> Sysfs show formats of files in /sys/devices/cpu/events/ are not unified,
> some end with "\n", and some do not. Modify sysfs show format of events
> defined by EVENT_ATTR_STR to end with "\n".

Did you test all the userspace that consumes these fields to make sure
none of them break? I suppose it's mostly perf tool, but I'm fairly sure
there's others out there as well.
