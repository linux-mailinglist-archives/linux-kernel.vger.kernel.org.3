Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E47557219
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiFWEsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbiFWDUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:20:02 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9DE1CFFB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:20:01 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c2so31105816lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=79v4g22d06dNQZx4XHZ3GsOIEc9zd0ggEjlq0srZKG4=;
        b=yrsZPHDCD9chqAOlK2aqkVDJbj4YlJK6Y1EmWC+AJelEirjFWQUhgxYZMRsapycCqT
         d9/sLvLnS2eOJcmjMAuTeVD27TGKvpamgOwFcYRj+mGYSFBLSmmSZXaBDE3SUZrHdL4+
         FNKvpXkRR1rlHo31238gF7oFTd6tugL+1j7VQ+5hZp3rK1Cgd3ZlEW1LGNL2qd2hO57J
         f/U0Jm7N2a2hUqpnKo8G4S1bfKfvBcNMD5a0B4I3FxQhigqDWQC/ibhSOKDneB2pXxZy
         tsvE9GxQXcHN3mCLB7R+5Pyv0PcHex0LGIVYsDNyVT5tKveqtjo8SRBsf4cRYjPoTNFQ
         Gh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=79v4g22d06dNQZx4XHZ3GsOIEc9zd0ggEjlq0srZKG4=;
        b=yvu7wiZl3++uGB60hdlEHmQ/LqaYO4M7URpn6bqiXxQU7srQ3f3n8lNzQvjPCxKsHR
         1eGtkANW+TwUsl9/52sB/LIgj6FSsStMqx6zFIllyO7hAohjKYQpuF6cExuE4nZVB5Q/
         FATSgZG0R9EczOhbWCaAiGbhcerp+2/XUVNYCeQPzOrKpKpOtuRCnXOGqvoplfUBoiiV
         I5lqF5pjVnEPp5zYY0IxPcIHQf6rhM04iEQ9+k4xudgCYAizwbm0tGeeSoQ6rVnkKLsV
         MID33bCk3o61jJgT65llXpCMRdC348oMgPRi1RcUXD/3vGrJdw+mIis5buLM2sFnk+UK
         WJrg==
X-Gm-Message-State: AJIora9y0E3Qe7RfNDxVFLnPosnVEdc4J+IvUSy2Hsd/+lquzPJ8hpmi
        tqPekB5DQPnNYgEbSWI0vbsKmA==
X-Google-Smtp-Source: AGRyM1sjcA+kIxAhm99wkWCmSIHuz3qmOx9TGh1uQ8/3JNaPFYlfZzhiTm1Jt9n2Mty+3YUw6m9sLw==
X-Received: by 2002:ac2:598b:0:b0:47f:9bf4:975a with SMTP id w11-20020ac2598b000000b0047f9bf4975amr3371926lfn.216.1655954399548;
        Wed, 22 Jun 2022 20:19:59 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s9-20020a056512214900b004790b5a0b22sm2799796lfr.239.2022.06.22.20.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 20:19:58 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 8F928104A32; Thu, 23 Jun 2022 06:22:11 +0300 (+03)
Date:   Thu, 23 Jun 2022 06:22:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        willy@infradead.org, zokeefe@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/16] mm/huge_memory: minor cleanup for
 split_huge_pages_pid
Message-ID: <20220623032211.rvrtlas25u7nddpt@box.shutemov.name>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-8-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622170627.19786-8-linmiaohe@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 01:06:18AM +0800, Miaohe Lin wrote:
> Use helper function vma_lookup to lookup the needed vma and use help macro
> IS_ERR_OR_NULL to check the validity of page to simplify the code. Minor
> readability improvement.

Grouping of changing seems random, but okay.

-- 
 Kirill A. Shutemov
