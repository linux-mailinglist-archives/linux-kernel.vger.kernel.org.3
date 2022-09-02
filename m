Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11BC5AB6E8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbiIBQxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236673AbiIBQxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:53:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF45F10952D;
        Fri,  2 Sep 2022 09:53:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C930B82CCC;
        Fri,  2 Sep 2022 16:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6FDC433C1;
        Fri,  2 Sep 2022 16:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662137621;
        bh=BF54yHPaOMKIqzLhCp+JxUXk0slqOuK/MTBsIODqbk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cIoq0HD0saj58EtD34tAbHSAX0ViBburZrWzfamK4+FFZNIjCLuY1nvv42QiGLKm1
         SEoZIsUBWZE1j4aEe2u89gDxpMYjuv9iX+/JGl9jzv9UA3Sfj4Ip4pChN2DISs9gwM
         mYK1ixlSgkzOFXAqf1FLh5bQpUiv6yG0SsuElZ8endymzkiw8PqG4Oj7KbgkI7rFKm
         Rx+x9uFXP110zoxA6+S5NGhHnJA+YhGYV/XbFcSAlkWK2dCmgMF0pxEF3rCHIjDEa3
         I4ezJ70jnzhgh978EXTcuTn+bY0uKrWxs+s4NishRffcWxNA+FsX7I9qvWfcx5fMXJ
         cmVvGpoP1VmCA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1CB6D404A1; Fri,  2 Sep 2022 13:53:38 -0300 (-03)
Date:   Fri, 2 Sep 2022 13:53:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     zhengjun.xing@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        ak@linux.intel.com, kan.liang@linux.intel.com
Subject: Re: [PATCH] perf stat: Fix L2 Topdown metrics disappear for raw
 events
Message-ID: <YxI1Eq1XzHf8O4L2@kernel.org>
References: <20220826140057.3289401-1-zhengjun.xing@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826140057.3289401-1-zhengjun.xing@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 26, 2022 at 10:00:57PM +0800, zhengjun.xing@linux.intel.com escreveu:
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> 
> In perf/Documentation/perf-stat.txt, for "--td-level" the default "0" means
> the max level that the current hardware support. So we need initialize the
> stat_config.topdown_level to TOPDOWN_MAX_LEVEL when “--td-level=0” or no
> “--td-level” option. Otherwise, for the hardware with a max level is 2, the
> 2nd level metrics disappear for raw events in this case. The issue cannot
> be observed for the perf stat default or "--topdown" options. This commit
> fixes the raw events issue and removes the duplicated code for the perf
> stat default.

Thanks, applied, sorry for the delay.

- Arnaldo
