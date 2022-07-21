Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086B257CC09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 15:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiGUNfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 09:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiGUNfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 09:35:20 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7561DEA7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8YFbTHxQthzOWNFDNujZ6xnF8BTNw3UEG0+j6FNXCWU=; b=snffF4nd3H4L5E8gMhriYYOREh
        Q71a9ezaDjUGUnhsZtzY8/6EqCqPZAZsLJWRRmW7bzR5EDMe31n5bfVa3A1mAYMihCLdi3uzzSvoT
        gDwXOgQkCwpnWcPbfySE+BwUB1JiP4NsH1DwT+Y0bS4ofjHH4Pjt8av2BZdtp8OzwOzdnHQy4Irkk
        HezfoOlKUFq7nOib9NARIY0vbDtnb/opPPQ68oZ4mdh3M5Du4xmxfyQ0uhMdZ9aqlBZXy7gGq8G32
        bB8tHDbluUYKSYw4HdZ1tfnvSiTr+uFH+1fM+5+Cpp9aA+MlL17DzfbllssIbqpxhgJy8IEgOmet8
        sAxzouGA==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220] helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oEWKh-001UuF-57; Thu, 21 Jul 2022 15:35:15 +0200
Message-ID: <14e11a4b-7300-a54d-6794-1eeb7ab8a079@igalia.com>
Date:   Thu, 21 Jul 2022 10:34:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] drm/amd/display: Remove duplicated
 CalculateWriteBackDISPCLK
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
Cc:     magalilemes00@gmail.com, christian.koenig@amd.com,
        Daniel Vetter <daniel@ffwll.ch>, Xinhui.Pan@amd.com,
        Alex Deucher <alexander.deucher@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        tales.aparecida@gmail.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, mwen@igalia.com,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Isabella Basso <isabbasso@riseup.net>, andrealmeid@riseup.net,
        Harry Wentland <harry.wentland@amd.com>,
        David Airlie <airlied@linux.ie>
References: <20220720182228.259119-1-mairacanal@riseup.net>
 <20220720182228.259119-2-mairacanal@riseup.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220720182228.259119-2-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Às 15:22 de 20/07/22, Maíra Canal escreveu:
> The functions dml30_CalculateWriteBackDISPCLK and
> dml31_CalculateWriteBackDISPCLK are identical. Therefor, to avoid
> code duplication, dml31_CalculateWriteBackDISPCLK is removed and
> replaced by dml30_CalculateWriteBackDISPCLK.
> 

The message should be in imperative mood:

"to avoid code duplication, dml31_CalculateWriteBackDISPCLK is removed
and replaced by dml30_CalculateWriteBackDISPCLK." -> "to avoid code
duplication, replace dml31_CalculateWriteBackDISPCLK by
dml30_CalculateWriteBackDISPCLK"

> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
> ---
