Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C89E5AA3FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiIAX6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiIAX6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:58:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD2B6C763;
        Thu,  1 Sep 2022 16:58:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D7A9B82897;
        Thu,  1 Sep 2022 23:58:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555F3C433C1;
        Thu,  1 Sep 2022 23:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662076718;
        bh=8N8RRa/GUsmMMJuIufQYY+tMakpxVYzcByXjf3hVKfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEOR2R0Oh4Tx7xDq6t+t/oUttp3mkFtlyOG6WTlSWJuUwQF+yfwRKHq/bVhcj9TsG
         R/nFV1uNANlEKiCHrm13ruZVkVKM99L78SFqU2m1SrtPCTcdVKSTBbIQURb61zFKCf
         aQTkiPDKWuxoTwTe3TTFBFgJGCUr1JwPQ8z38ttL8aR9cLvj0yAEkJTLNWVLW/6TQi
         aZywYFHvj75Fk061U4RX+ELa9RkserETF8eZyijJSt8As2sAGP06+EnmDNydVJsMRW
         lPeLJ5UpSFLbQ/62IoOlQGXh2rZvO+hfvzP+ctk+NGjsl7WTX6mTe0u31Ka0kodHAR
         biRN3Six6o7Zw==
Date:   Fri, 2 Sep 2022 02:58:34 +0300
From:   "jarkko@kernel.org" <jarkko@kernel.org>
To:     "Huang, Kai" <kai.huang@intel.com>
Cc:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Message-ID: <YxFHKttZMxbbmo5z@kernel.org>
References: <Yw7LJa7eRG+WZ0wv@kernel.org>
 <c3c085d69311ed759bff5bb325a2c182d423f91f.camel@intel.com>
 <Yw7OEh7QP8tb7BR1@kernel.org>
 <a91f65ad5c392b6e34f07bc6d3f35c89a76a98db.camel@intel.com>
 <op.1rrt4aecwjvjmi@hhuan26-mobl1.mshome.net>
 <Yw+oR3FKlwbeOl6I@kernel.org>
 <ea61a9ee-96dc-4f23-9de3-34e033391abc@intel.com>
 <94993d90b0b3c59fae61427cf0cc78dd10c381bb.camel@intel.com>
 <YxExyuA/+ptl0Y4G@kernel.org>
 <e1229a770fd2b4ec6642b921ec4a7e9ed0d11a3b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1229a770fd2b4ec6642b921ec4a7e9ed0d11a3b.camel@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:41:54PM +0000, Huang, Kai wrote:
> On Fri, 2022-09-02 at 01:27 +0300, jarkko@kernel.org wrote:
> > On Wed, Aug 31, 2022 at 08:42:59PM +0000, Huang, Kai wrote:
> > > On Wed, 2022-08-31 at 11:35 -0700, Dave Hansen wrote:
> > > > Jarkko, Kai and Haitao,
> > > > 
> > > > Can you three please start trimming your replies?  You don't need to and
> > > > should not quote the entirety of your messages every time you reply.
> > > > 
> > > > On 8/31/22 11:28, jarkko@kernel.org wrote:
> > > > > > Will it cause racing if we expose dev nodes to user space before
> > > > > > ksgxd is started and sensitization done?
> > > > > I'll to explain this.
> > > > > 
> > > > > So the point is to fix the issue at hand, and fix it locally.
> > > > > 
> > > > > Changing initialization order is simply out of context. It's
> > > > > not really an argument for or against changing it
> > > > > 
> > > > > We are fixing sanitization here, and only that with zero
> > > > > side-effects to any other semantics.
> > > > > 
> > > > > It's dictated by the development process [*] but more
> > > > > importantly it's also just plain common sense.
> > > > 
> > > > Kai, I think your suggestion is reasonable.  You make a good point about
> > > > not needing ksgxd for vepc.
> > > > 
> > > > *But*, I think it's a bit too much for a bugfix that's headed to
> > > > -stable.  I'm concerned that it will have unintended side effects,
> > > > *especially* when there's a working, tested alternative.
> > > 
> > > Agreed. Thanks Dave/Jarkko.
> > 
> > Please do a patch. It's a very reasonable suggestion when
> > considered out of context of this bug.
> > 
> > If you go really rigid with this, the compilation process
> > should not compile in sanitization process in the case when
> > only vepc is enabled. It's useless functionality in that
> > case.
> > 
> > BR, Jarkko
> 
> Yeah I am planning to work out one to see how it goes.

Looking forward to try it out :-)

BR, Jarkko
