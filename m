Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0127F4BF809
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiBVM0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiBVM0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:26:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C255D9EB95;
        Tue, 22 Feb 2022 04:26:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 734C7B819BA;
        Tue, 22 Feb 2022 12:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A3EC340E8;
        Tue, 22 Feb 2022 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645532768;
        bh=NM/LVf0ru3D5ozlA5ZdDWj5QZ/rpAt+B34/rzF83KBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eBL2/UtwTThkzuSytifGS49sEJNKEGOPsaANcJ09zJjMIqjA8rZAddPUTxf9NtC1x
         R8etYi4dylopJnX6uH0XGTCZvR/6Kc9uftm/XMZ+cx7fJgrCc1eukq6EIjLE6GT9q9
         wd+qc6NIZHTBcL81oYlT9ZjmZBN/0AtaK58xT+B9Jf4lzuDqoKwpk34PVzEfan5tt5
         d9gCJECNl49NGJG0enfbvKJ4BuzuTm6U4C8Oe/4icjbgg7PNvqTHsjNv/KyoSRFoq1
         2+UffbSPQ5fB5xoTwVQnHd0EquNBzMueCkfnFePhmy7hOjasbnJZvmXapGuFsHu/aH
         9CZe3mEoLkjOg==
Date:   Tue, 22 Feb 2022 13:26:45 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, ardb@kernel.org, jmorris@namei.org,
        serge@hallyn.com, nayna@linux.ibm.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v10 0/8] Enroll kernel keys thru MOK
Message-ID: <YhTWhcIx9B/pyiwD@iki.fi>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
 <YfFP6OHqBVNWKL2C@iki.fi>
 <YfFTf6vIpNMIrwH0@iki.fi>
 <78d2c13ad60b5f845cb841d257d1b41290f575c6.camel@linux.ibm.com>
 <YhKP12KEmyqyS8rj@iki.fi>
 <8e9e4bc3bbd831a606f264ec3f4dfcafdeebece6.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e9e4bc3bbd831a606f264ec3f4dfcafdeebece6.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 06:59:25AM -0500, Mimi Zohar wrote:
> On Sun, 2022-02-20 at 20:00 +0100, Jarkko Sakkinen wrote:
> > On Wed, Jan 26, 2022 at 05:06:09PM -0500, Mimi Zohar wrote:
> 
> > > > 
> > > > Mimi brought up that we need a MAINTAINERS update for this and also
> > > > .platform.
> > > > 
> > > > We have these:
> > > > 
> > > > - KEYS/KEYRINGS
> > > > - CERTIFICATE HANDLING
> > > > 
> > > > I would put them under KEYRINGS for now and would not consider further
> > > > subdivision for the moment.
> > > 
> > > IMA has dependencies on the platform_certs/ and now on the new .machine
> > > keyring.  Just adding "F: security/integrity/platform_certs/" to the
> > > KEYS/KEYRINGS record, ignores that dependency.  The discussion wouldn't
> > > even be on the linux-integrity mailing list.
> > > 
> > > Existing requirement:
> > > - The keys on the .platform keyring are limited to verifying the kexec
> > > image.
> > > 
> > > New requirements based on Eric Snowbergs' patch set:
> > > - When IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is enabled,
> > > the MOK keys will not be loaded directly onto the .machine keyring or
> > > indirectly onto the .secondary_trusted_keys keyring.
> > > 
> > > - Only when a new IMA Kconfig explicitly allows the keys on the
> > > .machine keyrings, will the CA keys stored in MOK be loaded onto the
> > > .machine keyring.
> > > 
> > > Unfortunately I don't think there is any choice, but to define a new
> > > MAINTAINERS entry.  Perhaps something along the lines of:
> > > 
> > > KEYS/KEYRINGS_INTEGRITY
> > > M:     Jarkko Sakkinen <jarkko@kernel.org>
> > > M:     Mimi Zohar <zohar@linux.ibm.com>
> > > L:      keyrings@vger.kernel.org
> > > L:      linux-integrity@vger.kernel.org
> > > F:      security/integrity/platform_certs
> > > 
> > 
> > This would work for me.
> 
> Thanks, Jarkko.  Are you planning on upstreaming this change, as you
> previously said, or would you prefer I do it?
> 
> thanks,
> 
> Mimi

This is the problem I'm encountering:

https://lore.kernel.org/keyrings/YhLNYxBTbKW62vtC@iki.fi/

BR, Jarkko
