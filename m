Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03A45ABED0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 13:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiICLtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 07:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiICLs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 07:48:56 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A18754AD;
        Sat,  3 Sep 2022 04:48:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VOBAkhS_1662205727;
Received: from 30.32.109.203(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0VOBAkhS_1662205727)
          by smtp.aliyun-inc.com;
          Sat, 03 Sep 2022 19:48:48 +0800
Message-ID: <a3b32e71-a345-40d3-feee-fa4c5aab42af@linux.alibaba.com>
Date:   Sat, 3 Sep 2022 19:48:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH][next] ocfs2: Replace zero-length arrays with
 DECLARE_FLEX_ARRAY() helper
Content-Language: en-US
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        akpm <akpm@linux-foundation.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <YxKY6O2hmdwNh8r8@work>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <YxKY6O2hmdwNh8r8@work>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/3/22 7:59 AM, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length array
> declarations in a couple of structures and unions with the new
> DECLARE_FLEX_ARRAY() helper macro.
> 
> This helper allows for a flexible-array member in a union and as
> only member in a structure.
> 
> Also, this addresses multiple warnings reported when building with
> Clang-15 and -Wzero-length-array.
> 
> Lastly, this will also help memcpy (in a coming hardening update)
> execute proper bounds-checking on variable length object i_symlink
> at fs/ocfs2/namei.c:1973:
> 
> fs/ocfs2/namei.c:
> 1973                 memcpy((char *) fe->id2.i_symlink, symname, l);
> 
> Link: https://github.com/KSPP/linux/issues/21
> Link: https://github.com/KSPP/linux/issues/193
> Link: https://github.com/KSPP/linux/issues/197
> Link: https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
