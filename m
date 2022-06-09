Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B275447AA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbiFIJgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiFIJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:36:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E3558E7B;
        Thu,  9 Jun 2022 02:36:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4DB521FDA8;
        Thu,  9 Jun 2022 09:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654767378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VvwjhH9UWKe8FrlHHhosAdnMECDi+CI7dFYYzh8hlOA=;
        b=rA2U7Q/wkWcXY/kcesb3Wc6YNg2eoiuocD7bBc9TDt6MpgMS958akfsf3KG50j8LOllzNj
        RLdT0LG7Rpqg6i1Sy/hWGR/zXhLXblNcZTMeLEgFW/FBZBI77+awNU2qClYTlwal1XWtjl
        KK9eSO1+59Llj1R4qY1Z9yg+Asa4E8U=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 825A62C141;
        Thu,  9 Jun 2022 09:36:16 +0000 (UTC)
Date:   Thu, 9 Jun 2022 11:36:15 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, oleksandr@natalenko.name,
        willy@infradead.org, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH] mm/ksm: provide global_force to see maximum potential
 merging
Message-ID: <YqG/Dyj62aDK/3Jr@dhcp22.suse.cz>
References: <20220609055658.703472-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609055658.703472-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-06-22 05:56:58, cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> Up to now, KSM is apparently useful to save memory not just for VM but for
> normal applications. But upper application developers might not know much
> about KSM or whether they should use madvise(xxx, MERGEABLE) while there
> indeed exist a lot of same pages in their apps. Some application developers
> urgently need the kernel to provide an interface of KSM debugging mode to
> see the maximum potential merging of the whole system, so the patch is.

I disagree with this. As already discussed in previous proposals of KSM
related interfaces KSM is a nice tool but it shouldn't be used without
understanding of all the consequences.

Maybe we should be more verbose about how to use KSM properly and also
describe best practices but I do not think that enable-for-all in any
form is a good interface.

Nack to the interface.
-- 
Michal Hocko
SUSE Labs
