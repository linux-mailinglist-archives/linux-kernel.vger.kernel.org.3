Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313AF53B62F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 11:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiFBJhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 05:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiFBJhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 05:37:31 -0400
X-Greylist: delayed 555 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Jun 2022 02:37:28 PDT
Received: from onstation.org (onstation.org [52.200.56.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F231FA69;
        Thu,  2 Jun 2022 02:37:27 -0700 (PDT)
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by onstation.org (Postfix) with ESMTPSA id CB1D841F4AA;
        Thu,  2 Jun 2022 05:28:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 onstation.org CB1D841F4AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onstation.org;
        s=default; t=1654162091;
        bh=TJORYCaZwleY0HJ0Sf6EGMw3BDRKmgvS6PExAz6yCvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9Zhw8gmnLUD6GQQOqxhbKZmH12gqLLXpIYzPr7GHSDLI7htIwMTtmFqeLm4j9Osn
         8fa2sKvEcM4pu/TaqXAyjunHdOhLIqpjQzbiirSjQk90qSlSPgMa4thYXAbpnBYf6e
         vMC7nBD16LPCp21cuuozStBnTxaiFlgKVMjRK2eo=
Date:   Thu, 2 Jun 2022 05:28:11 -0400
From:   Brian Masney <masneyb@onstation.org>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: ocmem: Fix refcount leak in of_get_ocmem
Message-ID: <20220602092811.GA9253@onstation.org>
References: <20220602042430.1114-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602042430.1114-1-linmq006@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 08:24:30AM +0400, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
> of_node_put() will check NULL pointer.
> 
> Fixes: 88c1e9404f1d ("soc: qcom: add OCMEM driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Reviewed-by: Brian Masney <masneyb@onstation.org>

