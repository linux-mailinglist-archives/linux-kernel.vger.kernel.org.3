Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEA757DC92
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiGVIl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGVIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:41:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5D11B7BA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 01:41:22 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lq2rD4J1mz67tVr;
        Fri, 22 Jul 2022 16:37:48 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Jul 2022 10:41:20 +0200
Received: from [10.195.247.3] (10.195.247.3) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 22 Jul
 2022 09:41:19 +0100
Message-ID: <6f18325e-cb40-b1f7-4236-3aa22e05694b@huawei.com>
Date:   Fri, 22 Jul 2022 09:41:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] scripts/faddr2line: Add CONFIG_DEBUG_INFO check
To:     Josh Poimboeuf <jpoimboe@kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1658426357.git.jpoimboe@kernel.org>
 <ffa7734c929445caa374bf9e68078300174f09b4.1658426357.git.jpoimboe@kernel.org>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <ffa7734c929445caa374bf9e68078300174f09b4.1658426357.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.247.3]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 19:01, Josh Poimboeuf wrote:
> Otherwise without DWARF it spits out gibberish and gives no indication
> of what the problem is.
> 
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>

Seems to work fine, thanks

Tested-by: John Garry <john.garry@huawei.com>

> ---
>   scripts/faddr2line | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 57099687e5e1..5514c23f45c2 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -61,6 +61,7 @@ die() {
>   READELF="${CROSS_COMPILE:-}readelf"
>   ADDR2LINE="${CROSS_COMPILE:-}addr2line"
>   AWK="awk"
> +GREP="grep"
>   
>   command -v ${AWK} >/dev/null 2>&1 || die "${AWK} isn't installed"
>   command -v ${READELF} >/dev/null 2>&1 || die "${READELF} isn't installed"
> @@ -271,6 +272,8 @@ LIST=0
>   [[ ! -f $objfile ]] && die "can't find objfile $objfile"
>   shift
>   
> +${READELF} --section-headers --wide $objfile | ${GREP} -q '\.debug_info' || die "CONFIG_DEBUG_INFO not enabled"
> +
>   DIR_PREFIX=supercalifragilisticexpialidocious
>   find_dir_prefix $objfile
>   

