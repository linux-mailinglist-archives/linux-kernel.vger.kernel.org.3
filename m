Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23A604E9129
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 11:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239764AbiC1JZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239758AbiC1JZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:25:21 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE56C12084;
        Mon, 28 Mar 2022 02:23:39 -0700 (PDT)
Message-ID: <bf4b8fe3-6dd6-4f3a-12f4-1b5bf2e45783@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648459417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jS168p1bb25ADdT8ax/fJafz6J3MhWjCNW24iJIjMs=;
        b=XhelexXO80TCyU/GIdoxY1UXAAdTSIKYfzOsp1TqrHHrkaCwSRNUn9dmom0UNDWN1pCirR
        qzdlTPV1em0IhNc3Xfa/BIf9I5BwkVBIhZtGAOz+G5jCphqJwlt4o7ATMzeTZmeUVqrzIV
        kW+4G3OGwXGB39GwCDMjSdZUwjzr97Q=
Date:   Mon, 28 Mar 2022 12:23:35 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH v2 RESEND] memcg: enable accounting for nft objects
Content-Language: en-US
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        kernel@openvz.org
References: <20220228122429.GC26547@breakpoint.cc>
 <47f5c00f-86e8-98b5-0cff-3b9fcadb590c@linux.dev> <YkFurEyv2RNwWROw@salvia>
In-Reply-To: <YkFurEyv2RNwWROw@salvia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/22 11:15, Pablo Neira Ayuso wrote:
> I think nft_*.c files whose NFT_EXPR_STATEFUL flag is set on need to
> use this _ACCOUNT flag variant for objects that are dinamically
> allocated from the packet path.

Thank you for the hint.
I think you're right in general, such objects should be accounted too.
Though this requires additional research, because it is not clear for me,
where proper memcg can be found.
In case of nft it was quite easy, memcg was taken from current task.
However, the objects you specified seem can be allocated in other contexts.

Thank you,
	Vasily Averin
