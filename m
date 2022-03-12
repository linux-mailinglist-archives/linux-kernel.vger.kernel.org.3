Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D124D6F46
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:48:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbiCLNtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiCLNth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:49:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F66043ED7;
        Sat, 12 Mar 2022 05:48:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F113B803F3;
        Sat, 12 Mar 2022 13:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC86C340EB;
        Sat, 12 Mar 2022 13:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647092909;
        bh=x3ngDXRTNxQtTUJ2tAIPdh6UG49UoIpaL6SxIce4GXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ndaIzAlDCK5DV6QonZCCsR+Pk2vhz4Q4FLdLUjZaIEPYUbTz2kAnp84WGLruKqIy7
         QIX5nuaQdK1xbmBUNlGq87dvUd8Z93vzKriNBq7UEdJsvDRyn//JiKyDEuO1rCWs8J
         PIMuNclNJeXP10VuJ5b0tMkoIf82H5CgWClAcI2tDN6pK8+cHmhq6ugWV7Uou1UAsW
         PBvGJyumGl7APHq6rwbNK9qxQ8VCJQbfFkxHP6HhUHMSEf/Cx8mgzR9f0FHS12qtWR
         cM5fTUpU40cOzgkTeb7QphruAAY/TDs/sq+qHUu8hc0LeMk+S/Uq+xhqzsnVbdWNHB
         I2ff9VBcYTkpw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 78EB9403C8; Sat, 12 Mar 2022 10:48:26 -0300 (-03)
Date:   Sat, 12 Mar 2022 10:48:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Weiguo Li <liwg06@foxmail.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf parse-events: Fix null check
Message-ID: <YiykquZ6QK/294sl@kernel.org>
References: <tencent_DF39269807EC9425E24787E6DB632441A405@qq.com>
 <a007c783-49a2-4ab3-a592-9f37ea41eaae@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a007c783-49a2-4ab3-a592-9f37ea41eaae@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 11, 2022 at 02:00:13PM +0000, John Garry escreveu:
> On 11/03/2022 13:06, Weiguo Li wrote:
> > We did a null check after "tmp->symbol = strdup(...)", but we checked
> > "list->symbol" other than "tmp->symbol".
> > 
> > Signed-off-by: Weiguo Li <liwg06@foxmail.com>
> 
> Reviewed-by: John Garry <john.garry@huawei.com>

Thanks, applied.

- Arnaldo

 
> > ---
> >   tools/perf/util/parse-events.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index 9739b05b999e..dfb50a5f83d0 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -2193,7 +2193,7 @@ int perf_pmu__test_parse_init(void)
> >   	for (i = 0; i < ARRAY_SIZE(symbols); i++, tmp++) {
> >   		tmp->type = symbols[i].type;
> >   		tmp->symbol = strdup(symbols[i].symbol);
> > -		if (!list->symbol)
> > +		if (!tmp->symbol)
> >   			goto err_free;
> >   	}

-- 

- Arnaldo
