Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531FA577EC7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiGRJgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiGRJgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:36:49 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D0D1ADA7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658137008; x=1689673008;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VIkFoRI5FsnReAuZJewimSARyWrBL4vaqa7hKMRx854=;
  b=Sp/tZN1lKC0nv09kw7gJjfL9fQw0O530E5PQU2KCjOIHwALNf4xfr6sA
   Gu0D4dZSvAuEhM/YKNukVz0nCmabGt8TV9UmwmTINZk4LfxmeH0vH4Df3
   JvDBoxhaK3BPf9VfHXnFOewcGT6v9TnV/2ZL/bhWxvb/l9z+FTOvULY0T
   Q=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 Jul 2022 02:36:48 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 02:36:48 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 18 Jul 2022 02:36:47 -0700
Received: from [10.233.21.232] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 18 Jul
 2022 02:36:45 -0700
Message-ID: <1c530e9b-3184-0113-d8ef-47548d7ab173@quicinc.com>
Date:   Mon, 18 Jul 2022 17:36:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] selftests/kprobe: Update test for no event name syntax
 error
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220718144007.78c5b50f9b123fb80a920054@kernel.org>
 <165812790993.1377963.9762767354560397298.stgit@devnote2>
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
In-Reply-To: <165812790993.1377963.9762767354560397298.stgit@devnote2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Masami,

On 7/18/2022 3:05 PM, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> The commit 208003254c32 ("selftests/kprobe: Do not test for GRP/
> without event failures") removed a syntax which is no more cause
> a syntax error (NO_EVENT_NAME error with GRP/).
> However, there are another case (NO_EVENT_NAME error without GRP/)
> which causes a same error. This adds a test for that case.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>   .../ftrace/test.d/kprobe/kprobe_syntax_errors.tc   |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> index 7c02509c71d0..9e85d3019ff0 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
> @@ -21,6 +21,7 @@ check_error 'p:^/bar vfs_read'		# NO_GROUP_NAME
>   check_error 'p:^12345678901234567890123456789012345678901234567890123456789012345/bar vfs_read'	# GROUP_TOO_LONG
>   
>   check_error 'p:^foo.1/bar vfs_read'	# BAD_GROUP_NAME
> +check_error 'p:^ vfs_read'		# NO_EVENT_NAME

i think you fix the issue which exist from start, right ?

is there better comment than NO_EVENT_NAME  ?

>   check_error 'p:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
>   check_error 'p:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
>   
>
