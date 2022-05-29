Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE0053701D
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 09:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiE2HEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 03:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiE2HEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 03:04:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544C4E22
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 00:04:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6303760DFA
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 07:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70C0C385A9;
        Sun, 29 May 2022 07:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653807868;
        bh=g0d7XWj5spS/zSjiU9vUdk8m7L82N5KavPTXtqWaMiU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mARWlsarSRXmB/SNy6OmN3kfPZfy7ryPcBlaboDQ80k8CZHZuU1nFi6YJ+/VQPNx7
         OOGenJnZQ8wmC6RaClqZ3q4jhTFI76k7EtVfjEbxVmYvOC28Mc2XohYJAv4olJjRGF
         RZyb5Dpn9GWPkbrHhr5l5ENGMa1Ktnzh7P2Bqd+tDYRYEp8AKUHlEP3P0OjW73JBnp
         tAO5+NQ50m1PUM9yR1lXAio8IygVeOgPveePAqmnQzOG6Gee9XHeUTJ55yD7Ls/4ww
         AkKHIEjE3UdlwdkdorflBrHT3FSblGEukPqgjQgLL9L229jtNqNRhxgnQbd4YScqDa
         Ke/Zdn6RxtQsw==
Message-ID: <5c41e440-93c0-9cf0-9960-446cd5d78837@kernel.org>
Date:   Sun, 29 May 2022 15:04:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] erofs: leave compressed inodes unsupported in fscache
 mode for now
Content-Language: en-US
To:     Jeffle Xu <jefflexu@linux.alibaba.com>, xiang@kernel.org,
        linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org
References: <20220526010344.118493-1-jefflexu@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220526010344.118493-1-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/26 9:03, Jeffle Xu wrote:
> erofs over fscache doesn't support the compressed layout yet. It will
> cause NULL crash if there are compressed inodes contained when working
> in fscache mode.
> 
> So far in the erofs based container image distribution scenarios
> (RAFS v6), the compressed RAFS v6 images are downloaded and then
> decompressed on demand as an uncompressed erofs image. Then the erofs
> image is mounted in fscache mode for containers to use. IOWs, currently
> compressed data is decompressed on the userspace side instead and
> uncompressed erofs images will be finally cached.
> 
> The fscache support for the compressed layout is still under
> development and it will be used for runtime decompression feature.
> Anyway, to avoid the potential crash, let's leave the compressed inodes
> unsupported in fscache mode until we support it later.
> 
> Fixes: 1442b02b66ad ("erofs: implement fscache-based data read for non-inline layout")
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
