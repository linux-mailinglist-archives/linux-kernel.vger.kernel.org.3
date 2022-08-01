Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5A586ED3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiHAQlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbiHAQlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:41:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3116427;
        Mon,  1 Aug 2022 09:41:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C7E960F9D;
        Mon,  1 Aug 2022 16:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554D7C433C1;
        Mon,  1 Aug 2022 16:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659372097;
        bh=vxWBXnawqlQkezkT2MfuFpk6srPiBr+yMl0+CH6pltw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fkz3mwZZd9slSj+Tz/CK4pGdXsqcmGiv9+h7ZvruEdACsS59uLdmyG2cRzS2a3tvb
         J+WycMhpNEPP/PsPFwpXIKf2rqmDMIckTxEFDaNzCQbwsrBGknhrqyPq4EjvtZ00jQ
         I5/vPDTGG5tZ923nmP6DeCj4C7wcLmgv4/KdvzVAu0hhYTBsJN5NDbW3dzqSUdWkMJ
         rqEKa0CWQpMzVwyIOdE+S8faqQUylZ8oYpv7wf7v4YqYnyZ/JwL/6Wl2Fkh2Yn8vHH
         Ur6psHY1vCpSFDyzca04tNzAv7OJvpxy39GOAIvO71yhqqk+h/0vCqUR1wmhADN4c+
         5lzEz9ksRiWxA==
Date:   Mon, 1 Aug 2022 19:41:32 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: Improve comments for
 sgx_encl_lookup/alloc_backing()
Message-ID: <YugCPNk7S0l53lbE@kernel.org>
References: <20220720182120.1160956-1-kristen@linux.intel.com>
 <YuJBjq/4dALm//rf@kernel.org>
 <fbf213f2-f118-ccfa-3faa-ec8b2182595b@intel.com>
 <YugCB3yj630goNhu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YugCB3yj630goNhu@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 07:40:42PM +0300, Jarkko Sakkinen wrote:
> On Thu, Jul 28, 2022 at 06:47:01AM -0700, Dave Hansen wrote:
> > On 7/28/22 00:58, Jarkko Sakkinen wrote:
> > > On Wed, Jul 20, 2022 at 11:21:19AM -0700, Kristen Carlson Accardi wrote:
> > >> Modify the comments for sgx_encl_lookup_backing() and for
> > >> sgx_encl_alloc_backing() to indicate that they take a reference
> > >> which must be dropped with a call to sgx_encl_put_backing().
> > >> Make sgx_encl_lookup_backing() static for now, and change the
> > >> name of sgx_encl_get_backing() to __sgx_encl_get_backing() to
> > >> make it more clear that sgx_encl_get_backing() is an internal
> > >> function.
> > >>
> > >> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > > The rename is unnecessary.
> > 
> > Well, it was done to address some reviewer confusion:
> > 
> > 	https://lore.kernel.org/all/YtUs3MKLzFg+rqEV@zn.tnic/
> > 
> > I wouldn't call it unnecessary.  Heck, I'd argue that the one of the
> > main reasons that this code leaked memory in the first place was the
> > naming and lack of comments.
> 
> Maybe the rename should be its own patch with this tag in the commit:
> 
> Link: https://lore.kernel.org/all/YtUs3MKLzFg+rqEV@zn.tnic/

Actually, just adding this to the current patch would be fine
(no need to split necessariy).

BR, Jarkko
