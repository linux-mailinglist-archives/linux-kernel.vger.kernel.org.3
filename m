Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909FF53B47A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiFBHkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiFBHkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:40:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3DAFDD4A;
        Thu,  2 Jun 2022 00:40:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76CAD1063;
        Thu,  2 Jun 2022 00:40:10 -0700 (PDT)
Received: from [10.57.38.114] (unknown [10.57.38.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29B353F66F;
        Thu,  2 Jun 2022 00:40:09 -0700 (PDT)
Message-ID: <47f72a91-6af1-d82f-8e4a-b8929725ff19@arm.com>
Date:   Thu, 2 Jun 2022 08:40:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] memory: samsung: exynos5422-dmc: Fix refcount leak in
 of_get_dram_timings
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>
References: <20220602041721.64348-1-linmq006@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-pm@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20220602041721.64348-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/22 05:17, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> This function doesn't call of_node_put() in some error paths.
> To unify the structure, Add put_node label and goto it on errors.
> 
> Fixes: 6e7674c3c6df ("memory: Add DMC driver for Exynos5422")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Thanks for the patch, LGTM.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

