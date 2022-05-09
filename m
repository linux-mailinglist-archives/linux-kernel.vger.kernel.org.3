Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C92C52068B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiEIVUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 17:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiEIVUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 17:20:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E0F1312AC
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 14:16:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E05961712
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 21:16:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5712EC385BB;
        Mon,  9 May 2022 21:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652130963;
        bh=N6R2HsKWImGfO3/giNuiFlILG8DRfdGzYPCqhOWYpjk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0oWEWV3uKiLb2ebg/5Cq5pobzcKiwy2nWOgUAakmacdPw7ntjndvIfvUSCpgPYDQO
         A488bJEY6ZrYG+2wgrjVhx9WSxVrEmH+shdxHy0Vn0dqkaQDdy3gfzpvzqBgmKYJ14
         WHWBPBXLE3fwJhDDCsLmiGzlz5AdXjJh1vGAOS2I=
Date:   Mon, 9 May 2022 14:16:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 10/15] mm/swap: break the loop if matching device is
 found
Message-Id: <20220509141602.b6be120b80d0ab3218fe619a@linux-foundation.org>
In-Reply-To: <20220509131416.17553-11-linmiaohe@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
        <20220509131416.17553-11-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 May 2022 21:14:11 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> We can break the loop if matching device is found to save some possible
> cpu cycles because there should be only one matching device and there is
> no need to continue if the matching one is already found.
> 
> ...
>
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1692,6 +1692,8 @@ int swap_type_of(dev_t device, sector_t offset)
>  				spin_unlock(&swap_lock);
>  				return type;
>  			}
> +
> +			break;
>  		}
>  	}
>  	spin_unlock(&swap_lock);

Are you sure?  If we have two S_ISREG swapfiles on the same device,
don't they have the same sis->bdev?

If not, why bother passing `offset' into this function at all?
