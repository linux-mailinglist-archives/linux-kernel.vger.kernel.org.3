Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A544E4549
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239789AbiCVRlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239787AbiCVRlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:41:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 97929888ED;
        Tue, 22 Mar 2022 10:39:39 -0700 (PDT)
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7A9A520DE47A;
        Tue, 22 Mar 2022 10:39:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7A9A520DE47A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1647970779;
        bh=PtoDzmpopQFbgY2xTih9vlGwSqLfSUwf2Sb2AlNYui8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZFY4mGZeTZxZubHGDUEMEI3uzak1GNiVV7uxJ3M2ACpQgDK88FSTC/razs0NRr/HY
         PumUlS81DS9EPqFCos4W04o1DJ2f9iVq7b1jSbBHiZd/WlYzpRNaqYEKfGYs7Fh/5o
         u6jQlQ1UdFqfPsvtfRoK0djRD0w2yaIzeYoq5Dws=
Date:   Tue, 22 Mar 2022 12:39:32 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v2 1/1] certs: Explain the rationale to call panic()
Message-ID: <20220322173932.GB7173@sequoia>
References: <20220322111323.542184-1-mic@digikod.net>
 <20220322111323.542184-2-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220322111323.542184-2-mic@digikod.net>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-22 12:13:23, Mickaël Salaün wrote:
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

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

Tyler

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
