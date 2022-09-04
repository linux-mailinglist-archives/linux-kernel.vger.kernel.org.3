Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070B05AC4A2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 16:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiIDOHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIDOHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:07:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05BC37FAC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 07:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DF2EB80D6F
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75469C433C1;
        Sun,  4 Sep 2022 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662300438;
        bh=PYB+j2rWkD12+mu6dPaP85tCcO89EDo5a32OV020+FE=;
        h=Date:From:To:Cc:Subject:From;
        b=kWV800L8x92UzF9gIDjcHdlkl9Q297stWL6bvgu7NY+LJRlvBOCy2pl3APYP7Wn01
         lBLOirJk/bG1YyAmYpaa5+01z9AcvJF+KgAMCwL+9SK/jSYhcASJQDANMn/+60hN+a
         jBwuRGPRkHS+zflIHrEIpKM0ftFe1CmZnknmW6rrrcTJU8o7ZCf8rQ2+a94Y28K2+r
         thfvxAfbg/XpmIlPbac+8+hdxMJbsNb9EYFJqQx02w6r9D+sMb7l6J9pW3cq8xg4/e
         pSENrSxCvfTJ+f1slmKRWI9XoV8dFntFgBmkxulRCVGKNE4/yYUm21BGRa29EkUJkT
         8GmOQeJivj2jg==
Date:   Sun, 4 Sep 2022 23:07:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@suse.de>, Josh Poimboeuf <jpoimboe@kernel.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: CONFIG_RETHUNK int3 filling prevents kprobes in function body
Message-Id: <20220904230713.a461f8fe85329663226c755f@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

I found that the CONFIG_RETHUNK code (path_return) fills the unused bytes
with int3 for padding. Unfortunately, this prevents kprobes on the function
body after the return code (e.g. branch blocks placed behind the return.)

This is because kprobes decodes function body to ensure the probed address
is an instruction boundary, and if it finds the 0xcc (int3), it stops
decoding and reject probing because the int3 is usually used for a
software breakpoint and is replacing some other instruction. Without
recovering the instruction, it can not continue decoding safely.

Can we use another instruction for padding instead of INT3? (e.g. NOP or UD2)

Or, can I expect the instruction length in __return_sites[] are always 5?
If so, I can just skip 5 bytes if the address is in __return_sites[].

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
