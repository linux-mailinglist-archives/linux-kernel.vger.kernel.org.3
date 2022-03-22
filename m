Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE18D4E478D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbiCVUdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiCVUdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:33:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E6BCC2;
        Tue, 22 Mar 2022 13:32:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A37B616F6;
        Tue, 22 Mar 2022 20:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64379C340EC;
        Tue, 22 Mar 2022 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647981133;
        bh=o3E0Y08RPMj1egwbWNbnzxUc/jwp9wDcfpxs75c2JQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ontDsE0ma8rQ6pUD/sa6Q9cAXKh9FhrP8mGAWHHEmq0wEDG92pqmJrhnXP4NviOQ+
         90NY8lR0hbLWLGfsZSK6v4pw158Ipcliq9q5NwvZUPTUFN67ZflLz/Y6SLfZ+7lEQC
         U1rHhKx6ygQWnf+XpUe0Qh2SFLwMOvgLFfhwLVD7DzF6zDVPWLI91XuQLhPNhg9oth
         ZMhgAnG/c+Hqu0j+rUNuGqohfwhdxLQjuqfnzFv0TIbWp0xH2f+N8eJMuA7cDaMf+o
         DQugWz7ATJaFSeDyz7jCqrs9L0HWlZ+UlO4q7uGKoZNx9KUf2WaNEubvEmAOSc9fwa
         jmhHZPhvJyHYQ==
Date:   Tue, 22 Mar 2022 22:31:19 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v2 1/1] certs: Explain the rationale to call panic()
Message-ID: <YjoyF02zD5WdAMOW@iki.fi>
References: <20220322111323.542184-1-mic@digikod.net>
 <20220322111323.542184-2-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220322111323.542184-2-mic@digikod.net>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 12:13:23PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> The blacklist_init() function calls panic() for memory allocation
> errors.  This change documents the reason why we don't return -ENODEV.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com> [1]
> Requested-by: Jarkko Sakkinen <jarkko@kernel.org> [1]
> Link: https://lore.kernel.org/r/YjeW2r6Wv55Du0bJ@iki.fi [1]
> Reviewed-by: Paul Moore <paul@paul-moore.com>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> Link: https://lore.kernel.org/r/20220322111323.542184-2-mic@digikod.net
> ---
> 
> Changes since v1:
> * Fix commit subject spelling spotted by David Woodhouse.
> * Reword one sentence as suggested by Paul Moore.
> * Add Reviewed-by Paul Moore.
> * Add Reviewed-by Jarkko Sakkinen.
> ---
>  certs/blacklist.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index 486ce0dd8e9c..25094ea73600 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c
> @@ -307,6 +307,15 @@ static int restrict_link_for_blacklist(struct key *dest_keyring,
>  
>  /*
>   * Initialise the blacklist
> + *
> + * The blacklist_init() function is registered as an initcall via
> + * device_initcall().  As a result if the blacklist_init() function fails for
> + * any reason the kernel continues to execute.  While cleanly returning -ENODEV
> + * could be acceptable for some non-critical kernel parts, if the blacklist
> + * keyring fails to load it defeats the certificate/key based deny list for
> + * signed modules.  If a critical piece of security functionality that users
> + * expect to be present fails to initialize, panic()ing is likely the right
> + * thing to do.
>   */
>  static int __init blacklist_init(void)
>  {
> -- 
> 2.35.1
> 

Thank you, I'll put this into my "queue" folder and apply as soon I have
bandwidth.

BR, Jarkko
