Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D24E7CDA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiCYT3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 15:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiCYT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:28:34 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472521EC9B7;
        Fri, 25 Mar 2022 12:02:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A00793F928D;
        Fri, 25 Mar 2022 14:37:33 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id o23C3DmGDikb; Fri, 25 Mar 2022 14:37:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1AAED3F928C;
        Fri, 25 Mar 2022 14:37:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1AAED3F928C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1648233453;
        bh=mwGMi7DQv+rIpXzPKYAh0aILg4rx7+9wE3psHKG8Ox8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FFq8Id9RI4B+MAqAqNdDDT49nMdWQGHbMV0Vh81Wg8rKc9vZ6RZeZRvU25frcTrlI
         IyZmFRltt6UDeUjQzOL3MQYFy+oMO2AUv/LZQgMcQ2sQf+WaACwOW+EEA0t53znUPJ
         OQKikP7noZV+XcsnJ0YD27DpE5H+Bgx+lFohmuGJwsHiHXfCTaqUYrAS8ZFzRdO83J
         4WTXE0UBk5xoZX3QREMglFPX0FmwYEA2ov/H6fLRx3Y8p1xLr+CcaM1aOSl59yGIQu
         FJxS1qNl0VG9p4EoelXanXI2mIrp8AdNGKa1JIBYXR2VQsoOWNS2LujOnHu+WgdVYd
         JDtdtWtGzDu9A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Rmp3GDtL7f2D; Fri, 25 Mar 2022 14:37:33 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 0CDB93F8FCC;
        Fri, 25 Mar 2022 14:37:33 -0400 (EDT)
Date:   Fri, 25 Mar 2022 14:37:32 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1722467374.194740.1648233452935.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.13.3 and 2.12.8 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF98 (Linux)/8.8.15_GA_4232)
Thread-Index: FdzCaxNCbhjFfBx2k4zpzfddPUUTBg==
Thread-Topic: LTTng-modules 2.13.3 and 2.12.8 (Linux kernel tracer)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a stable release announcement for the LTTng kernel tracer for the
stable 2.12 and 2.13 branches. The releases are respectively 2.12.8 and 2.13.3.

In the 2.13.3 release, two fixes are worth mentioning:

* Fix: lttng ABI: lttng_counter_ioctl() tainted scalar

    The counter aggregate, clear and read functions (used for error reporting of
    the event notification feature) use a userspace-controlled "number_dimensions"
    argument as loop boundary.

    This ABI is only accessible from the root user, which limits the practical impact
    of this bug.

* Fix: sample discarded events count before reserve

    Sampling the discarded events count in the buffer_end callback is done
    out of order, and may therefore include increments performed by following
    events (in following packets) if the thread doing the end-of-packet
    event write is interrupted for a long time.
    
    Sampling the event discarded counts before reserving space for the last
    event in a packet, and keeping this as part of the private ring buffer
    context, should fix this race.
    
    In lttng-modules, this scenario would only happen if an interrupt
    handler produces many events, when nested over an event between its
    reserve and commit. Note that if lttng-modules supports faultable
    tracepoints in the future, this may become more easy to trigger due to
    preemption.

    This fix is only part of the 2.13 stable branch and not backported to
    2.12 because the lib ring buffer code used to implement this fix did not
    exist in 2.12. Given that the impact of this bug is only imprecision of
    discarded event reporting in corner-case scenarios (small impact, rare
    occurrence), the complexity of implementing this fix in 2.12 is not justified.
    The effect of this issue is that the lttng-tools
    tests/regression/tools/streaming/test_high_throughput_limits test is flaky.

In the 2.12.8 release, a series of commits introduce support for the 5.17 Linux kernel.
The 2.13 stable branch already supported that kernel in the prior releases.

Feedback is welcome!

Thanks,

Mathieu

Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
