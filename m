Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F21EE564355
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 01:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiGBXvm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 19:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGBXvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 19:51:41 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E87B4AB;
        Sat,  2 Jul 2022 16:51:39 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 70936C01F; Sun,  3 Jul 2022 01:51:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656805898; bh=Zm5xiOI3tzjPZ5dH6z84+OwIZ0P84+PXbsyPyxuxS2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJWDzq2+FWAHHGPBavPpzlQQoKg8jGGiAPOHS/YDqaDMSGb90ZB3E7r9/sWkAAGV5
         ME8fn4DQJyKzE3Aso4JK/sqXKvKuZ8XeYMzeYwW/TggciXR6aa5o1jSXmPogcCoJXU
         d6mT7lE8uYbblb3s/pIsnIZ+BXqCTKQ8gmiEnHZbGbphikhagl5YQo1HTfKBubHCKF
         LsqZ5k0A592iv8RRBV1wXzX6XbYgd3S9FzARjm3su3kY7euq04fiYLiMVmYSIB0WEv
         MB3LTSOQoUehRxfZIoLXgZbaj92YW44GMqMP9gTRaDjMU5Y7ELvXK/vzRaMSx6555X
         m33uaY7Vppq+g==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id BE809C009;
        Sun,  3 Jul 2022 01:51:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656805897; bh=Zm5xiOI3tzjPZ5dH6z84+OwIZ0P84+PXbsyPyxuxS2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OM1PqoewUlNlwRC2XmRHT8lRxzkovhVmiMEZSmsa20jap5ziWLN8StHfoJnIIuBnj
         AENcu1vSRkxoyTKUHbveKhDqqeDvO1H4vfmTX0DSugL2Lk3gBc3moRkiLrmnZDSIc6
         spLUJuVIIqYIJpw1SZGodxOm5ZxS94fTGQezuR4CUr/tIBlMXFmDhyHHqJinT3djMX
         5KNGx5p8o0/YNo1sprdyqttUOV4PTwHZ/m2jTAe2DtLswwzSj2CXP4XRohOPHLokwd
         5ggqwqntabIxuxthKL0TMsVRHNX8e0MuLqop4+UYky31R8fp5w1Xm0dZzwPTNg4o1S
         5maJ/DlRk6QAA==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 9729a9d2;
        Sat, 2 Jul 2022 23:51:30 +0000 (UTC)
Date:   Sun, 3 Jul 2022 08:51:14 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse: Allow names to start with digits
Message-ID: <YsDZ8mTnCQzpejOM@codewreck.org>
References: <20220612061508.1449636-1-asmadeus@codewreck.org>
 <YsAUqwzeO8U6cIJA@codewreck.org>
 <YsA4+A7TSjzUKDWK@kernel.org>
 <YsBosxs9TVB0aLrf@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YsBosxs9TVB0aLrf@krava>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Olsa wrote on Sat, Jul 02, 2022 at 05:48:03PM +0200:
> > > > -name		[a-zA-Z_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> > > > +name		[a-zA-Z0-9_*?\[\]][a-zA-Z0-9_*?.\[\]!]*
> 
> I thought it'd clash with events like cpu/event=3/,
> but lexer check numbers first, so we're fine there
> 
> it smells like it could break some events, but I couldn't
> find any case of that
> 
> could you please at least add tests to tests/parse-events.c
> for such case?

hmm, I'd love to but on my system I have no events that start with a
number unless I manually modprobe 9pnet (or 802154 stuff), so tests
would start failing for most people and I don't think we want that...

I have confirmed the following 'perf test "event parsing"' works iff
patch is applied and 9pnet loaded:
---- 
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 459afdb256a1..3d069fe9eb79 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1941,6 +1941,11 @@ static const struct evlist_test test__events[] = {
 		.check = test__exclusive_group,
 		/* 7 */
 	},
+	{
+		.name  = "9p:9p_client_req",
+		.check = test__checkevent_tracepoint,
+		/* 8 */
+	},
 };
 
 static const struct evlist_test test__events_pmu[] = {
----

not sure if there'd be any other way of testing, there's nothing else in
'perf list' that starts with a number.
--
Dominique
