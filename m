Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270FC507B17
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357694AbiDSUlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239482AbiDSUlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:41:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D744240919;
        Tue, 19 Apr 2022 13:39:07 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650400746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=ACSVUlvGnqDZI2n71F28I0TraOl9Yjs3dUvYrfjMAHE=;
        b=gjZOttOHsTC2IeAYYI8gJJsDMLeapuokRo9d3LngjStAjVCEpz9yeP4wMh3MubEibH/RYo
        FJB46Yqw3rcAtbObntvaq/MiFTU4L3MnMQvowMGoUtfpzHbGiZMN5wH0Y99pzRScO/wvdz
        1e0t6uHj79BlIpFfQEnOeks4CjO0uZDTfAa82mQp+/gmrM+tMhYXBDqqW9DqIe3vtyIAc3
        kxBrJCVHLH6V7tKyiqwni2sCDJ9LMnwPxh7EYhQUD8/zvD7HjNh1W/McYT57dqKUBWvyt1
        A0EX1iYIIxHKF/SImeyvfd3nTPrT2B05ZnTN+SFKbOk9tmY5gC9Mv143XDabLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650400746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=ACSVUlvGnqDZI2n71F28I0TraOl9Yjs3dUvYrfjMAHE=;
        b=YwiIFsSMYgXWCova882NKcGbknygqHXvKBp+PcwZxRwR9rm7PQWhBxswoKQ2Z9KyXYmNAH
        5gpJlQe6VDxHOWDg==
To:     Eric Dumazet <edumazet@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [patch 00/10] x86/cpu: Consolidate APERF/MPERF code
In-Reply-To: <CANn89iL+CHRi1HJ6Mp4u=ECnfAXV2qxXZj_BsQuv+uwheAfDDw@mail.gmail.com>
Date:   Tue, 19 Apr 2022 22:39:05 +0200
Message-ID: <87ee1svmdy.ffs@tglx>
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

Eric,

On Tue, Apr 19 2022 at 08:51, Eric Dumazet wrote:
> On Fri, Apr 15, 2022 at 12:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> It could be argued that not all APERF/MPERF capable systems have the
>> required BIOS information to enable frequency invariance support, but in
>> practice most of them do. So the APERF/MPERF sampling can be made
>> unconditional and just the frequency scale calculation for the scheduler
>> excluded.
>>
>> The following series consolidates that.
>>
>
> Thanks a lot for working on that Thomas.
>
> I am not sure I will be able to backport this to a Google prodkernel,
> as I guess there will be many merge conflicts.

:)

> Do you have by any chance this work available in a git branch ?

 git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/amperf

Thanks,

        tglx
