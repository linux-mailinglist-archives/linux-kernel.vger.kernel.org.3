Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B305F4FE6CB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357364AbiDLR3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiDLR3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:29:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C258252B2A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:26:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E3A3B81F5B
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 17:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69718C385A1;
        Tue, 12 Apr 2022 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649784405;
        bh=5fBiB9n+naRmExVYTrfBR6Y0GO2FDmg4/T8dW79QLCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uybX+7vqcUMrlKabYMrKLxwaPbspd2HZmFKgjmSgNwUo5KRUgiqpc/0eVigepUKEL
         pxGEKibtkMnxIcTFszfqT2CP7qzlIc+eA+lkZPZ45D+dNd+M54X2IqpnmMIJRMRF4B
         7iXxsupYtPcHTnOvS324q9mMJjHUP2XTeVI4T7DfsBIZAzzqPvrrslpTU8Oq/LX/rn
         LplL6FUmJiem1Y/kuTLA/X3MH7KkFUK/26cC0K5CgkDO7L8EeXmzk+7DSovcenZfKF
         P5XzAX5TwfYYMpjHnOqDAE5KqKzuZGsU/fgBEYUADuxNFaoawqZUjRaS2awQvI0nNy
         GQV+Uk8lVNMJg==
Date:   Tue, 12 Apr 2022 20:26:36 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Faiyaz Mohammed <quic_faiyazm@quicinc.com>
Cc:     quic_vjitta@quicinc.com, karahmed@amazon.de, qperret@google.com,
        robh@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memblock: avoid to create memmap for memblock nomap
 regions
Message-ID: <YlW2TO0O8qDHpkGW@kernel.org>
References: <1649704172-13181-1-git-send-email-quic_faiyazm@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649704172-13181-1-git-send-email-quic_faiyazm@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:39:32AM +0530, Faiyaz Mohammed wrote:
> This 'commit 86588296acbf ("fdt: Properly handle "no-map" field in the
> memory region")' is keeping the no-map regions in memblock.memory with
> MEMBLOCK_NOMAP flag set to use no-map memory for EFI using memblock api's,
> but during the initialization sparse_init mark all memblock.memory as
> present using for_each_mem_pfn_range, which is creating the memmap for
> no-map memblock regions. To avoid it skiping the memblock.memory regions
> set with MEMBLOCK_NOMAP set and with this change we will be able to save
> ~11MB memory for ~612MB carve out.

The MEMBLOCK_NOMAP is very fragile and caused a lot of issues already. I
really don't like the idea if adding more implicit assumptions about how
NOMAP memory may or may not be used in a generic iterator function.

-- 
Sincerely yours,
Mike.
