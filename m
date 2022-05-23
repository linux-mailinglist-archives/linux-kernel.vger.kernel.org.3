Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2339B531844
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbiEWSR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243587AbiEWSB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:01:57 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA59DFF48;
        Mon, 23 May 2022 10:46:51 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B981660A;
        Mon, 23 May 2022 17:46:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B981660A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1653327965; bh=tKg2U0MvNTJAYNl6IAoyEFljp3YdzFQOTMvhJuCB7vw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=M8bVJTBgGchdemxpZMG8x4ui4vpVchupoKVbrRx8XiuM24+s4+3VDXEa9zJcDyRm9
         aKa5VFSNgvNL2YktRd35Qc0+RI5Yx2qsv9yoh8Q+EmfuLI/l1BOYozhH7vAYGhhTO+
         fTYW5iySlsQ3krhbMQxNcT74AWOhF41Bk/WWY/hADh6aU6Syh41n9TvDTVoHGoZ7/0
         UQX6pqO+lb75dpi+JBmrb6GVKJLoo2rGyHDYb5cQNRa3JrccCNCtz4/BBfO/NWQylF
         yjXwHwnquaWSzMFZW83wMQ3Zyt7GWAfBM9Zct1nH/q/zyOry2TaqTQzck1dfg08etg
         nBi9EfqudA4wg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rafael@kernel.org, hdegoede@redhat.com, markgross@kernel.org
Cc:     lenb@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] Documentation: admin-guide: pm: Add Out of Band mode
In-Reply-To: <20220523172757.2351052-1-srinivas.pandruvada@linux.intel.com>
References: <20220523172757.2351052-1-srinivas.pandruvada@linux.intel.com>
Date:   Mon, 23 May 2022 11:46:04 -0600
Message-ID: <871qwkb0rn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> writes:

> Update documentation for using the tool to support performance level
> change via OOB (Out of Band) interface.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  .../admin-guide/pm/intel-speed-select.rst     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/Documentation/admin-guide/pm/intel-speed-select.rst b/Documentation/admin-guide/pm/intel-speed-select.rst
> index 0a1fbdb54bfe..4146a2da35ea 100644
> --- a/Documentation/admin-guide/pm/intel-speed-select.rst
> +++ b/Documentation/admin-guide/pm/intel-speed-select.rst
> @@ -262,6 +262,25 @@ Which shows that the base frequency now increased from 2600 MHz at performance
>  level 0 to 2800 MHz at performance level 4. As a result, any workload, which can
>  use fewer CPUs, can see a boost of 200 MHz compared to performance level 0.
>  
> +Changing performance level via BMC Interface
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +It is possible to change SST-PP level using out of band (OOB) agent (Via some
> +remote management console, through BMC "Baseboard Management Controller"
> +interface). This mode is supported from the Sapphire Rapids processor
> +generation. The kernel and tool change to support this mode is added to Linux
> +kernel version 5.18. To enable this feature, kernel config
> +"CONFIG_INTEL_HFI_THERMAL" is required. The minimum version of the tool
> +is "v1.12" to support this feature, which is part of Linux kernel version 5.18.
> +
> +To support such configuration, this tool can be used as a daemon. Add
> +a command line option --oob::
> +
> +# intel-speed-select --oob
> +

This suggests you haven't actually built the documentation with your
change and verified that you got the result you were after.  Literal
blocks need to be indented.

Thanks,

jon
