Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AC153EE0A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231951AbiFFSqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbiFFSpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:45:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDCC6D3A0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:45:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a15so24701873lfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 11:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YkCyZwQdYZTEEFPTy/Pdu0PQJcmELT6TknKthn7ttDg=;
        b=deix4g5mlMz7MedyxE6BvRxtcx1qmV7hufSdLPima/2dHFwtRnvmns59Vp6gEAkztF
         90b2gCLoUi5EVPk6nXdr6ediy095+6ZfsuLjNPu5qRsd7QOZTecIdy59UABjymdHhFd3
         CukWdELH4OvdCFhuTVVy9+PmqESzOBgHOUopOMe+C8iuPNajSYon0HtA76QY/u2l6PH5
         SD0w4cILSzdVngDPpmKM0214udBMV+byCbRyCfOT1sh7G5ATPMpUcDTTRwB51H66TnWl
         RS2dIGgQtmQ63/fssQV7UvuMBjcEuR6b1ehBFkFFiZ4fhPvgQdIc6/NiAg67Uo7+x/Sa
         OJsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YkCyZwQdYZTEEFPTy/Pdu0PQJcmELT6TknKthn7ttDg=;
        b=uKIBNvao7LV2FhO6Zmu/JpRoUrPZQNu3w9nFOCQsmyc6V4QJbw+T2Vu4TftdUs3M9U
         7RSjo3lcz1YYRUCR5kQnJefY5aCvbRiMM9eN//YhoFIQs3Iaw25gmPZx+jjRlB980qul
         dTMQtJecvmWS0fyH4VE0HVwIk5n+xwVc5Oww9XFoojGsKeMcRdCH80RQ6Sc2lHpuqIot
         wQiV1PEmmOR90De8ta29N93JOWxmIrKdshIdDIUCuhkdyNSHo6ibMrHprd4FhKlH+5+w
         vnSVQEn3wVE8vLTTdFJ1xL3X6CCTJeTpAGo844P+QFH8qqTaShtW5IGGAWuV8V2vGXRa
         3+jg==
X-Gm-Message-State: AOAM530y4DGOA6RQLFRflSDIbpOaGjq70Iu/Nzfnjp8nliBeX/iF/zzN
        ciQ1PqWfTMSf6ZlXRZaAa57KEA==
X-Google-Smtp-Source: ABdhPJwilY+RIM62AvlM0Aj7uuc/2RFRRcO3Lqoy+mUCD59lfzw8gGdGQNfMfrbU7WGYeeF0bN+Oqw==
X-Received: by 2002:a05:6512:3f97:b0:44a:f67d:7d8 with SMTP id x23-20020a0565123f9700b0044af67d07d8mr15650773lfa.81.1654541152297;
        Mon, 06 Jun 2022 11:45:52 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id q21-20020a0565123a9500b004795a3181absm192009lfu.69.2022.06.06.11.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jun 2022 11:45:51 -0700 (PDT)
Message-ID: <360a2672-65a7-4ad4-c8b8-cc4c1f0c02cd@openvz.org>
Date:   Mon, 6 Jun 2022 21:45:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH memcg v6] net: set proper memcg for net_init hooks
 allocations
Content-Language: en-US
To:     Qian Cai <quic_qiancai@quicinc.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>, cgroups@vger.kernel.org
References: <6b362c6e-9c80-4344-9430-b831f9871a3c@openvz.org>
 <f9394752-e272-9bf9-645f-a18c56d1c4ec@openvz.org> <Yp4F6n2Ie32re7Ed@qian>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <Yp4F6n2Ie32re7Ed@qian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 16:49, Qian Cai wrote:
> On Fri, Jun 03, 2022 at 07:19:43AM +0300, Vasily Averin wrote:

> This triggers a few boot warnings like those.
> 
>  virt_to_phys used for non-linear address: ffffd8efe2d2fe00 (init_net)
>  WARNING: CPU: 87 PID: 3170 at arch/arm64/mm/physaddr.c:12 __virt_to_phys
...
>  Call trace:
>   __virt_to_phys
>   mem_cgroup_from_obj
>   __register_pernet_operations

@@ -1143,7 +1144,13 @@ static int __register_pernet_operations(struct list_head *list,
  		 * setup_net() and cleanup_net() are not possible.
		 */
		for_each_net(net) {
+			struct mem_cgroup *old, *memcg;
+
+			memcg = mem_cgroup_or_root(get_mem_cgroup_from_obj(net));   <<<<  Here
+			old = set_active_memcg(memcg);
 			error = ops_init(ops, net);
+			set_active_memcg(old);
+			mem_cgroup_put(memcg);
...
+static inline struct mem_cgroup *get_mem_cgroup_from_obj(void *p)
+{
+	struct mem_cgroup *memcg;
+
+	rcu_read_lock();
+	do {
+		memcg = mem_cgroup_from_obj(p); <<<<
+	} while (memcg && !css_tryget(&memcg->css));
...
struct mem_cgroup *mem_cgroup_from_obj(void *p)
{
        struct folio *folio;

        if (mem_cgroup_disabled())
                return NULL;

        folio = virt_to_folio(p); <<<< here
...
static inline struct folio *virt_to_folio(const void *x)
{
        struct page *page = virt_to_page(x); <<< here

... (arm64)
#define virt_to_page(x)         pfn_to_page(virt_to_pfn(x))  
...
#define virt_to_pfn(x)          __phys_to_pfn(__virt_to_phys((unsigned long)(x)))
...
phys_addr_t __virt_to_phys(unsigned long x)
{
        WARN(!__is_lm_address(__tag_reset(x)),
             "virt_to_phys used for non-linear address: %pK (%pS)\n",

from arch/x86/include/asm/page.h:
 * virt_to_page(kaddr) returns a valid pointer if and only if
 * virt_addr_valid(kaddr) returns true.

As far as I understand this report means that 'init_net' have incorrect
virtual address on arm64.

Roman, Shakeel, I need your help

Should we perhaps verify kaddr via virt_addr_valid() before using virt_to_page()
If so, where it should be checked?

Thank you,
	Vasily Averin
