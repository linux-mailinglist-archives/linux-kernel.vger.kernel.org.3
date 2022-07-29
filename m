Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7775584A80
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 06:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbiG2EC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 00:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiG2ECX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 00:02:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5E87CB69;
        Thu, 28 Jul 2022 21:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4ECEB8254E;
        Fri, 29 Jul 2022 04:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F136FC433D6;
        Fri, 29 Jul 2022 04:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659067340;
        bh=U+lGdFsTv3JKZCf9r8fYYpz91ylrFsMPO+0gFcn3ygc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CmO5HHW9ewZI5nrgKYO1bgNT7Xcj3WK0NMacT7PPJvyH7R06rm5v2XkuwRRWQHZ5v
         +f2FFU95hJg3CBM+6mwSzx2UZ+RLVVntnrQXX4xuzBewzZtBp18CZ70XryDifm9NzP
         meoBRZ60c73ogSGf/wPMXuyTuIIjiSR+GEzugtAsK0PGS71S680qgLKMGhYaAeVaq+
         O8n92J3HKmy3Vv5os2X+w+MewWVgemyZYaWS8JwNW5uUYup4oKA79QMIw7o9WgNcoK
         qwxYgxFOMQb8GW7yPi5BpXmwyF/3r7LgkzT3FwUciVCq/+ptGae8j9N99VDrev6xH1
         Lv6cGjU8TZ8pA==
Date:   Thu, 28 Jul 2022 21:02:18 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Can Guo <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3 2/2] ufs: core: print UFSHCD capabilities in
 controller's sysfs node
Message-ID: <YuNbyt/mjgGWWUQr@sol.localdomain>
References: <20220729020508.4147751-1-dlunev@chromium.org>
 <20220729120216.v3.2.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729120216.v3.2.Ibf9efc9be50783eeee55befa2270b7d38552354c@changeid>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 12:05:08PM +1000, Daniil Lunev wrote:
> +What:		/sys/bus/platform/drivers/ufshcd/*/capabilities/crypto
> +What:		/sys/bus/platform/devices/*.ufs/capabilities/crypto
> +Date:		July 2022
> +Contact:	Daniil Lunev <dlunev@chromium.org>
> +Description:	Indicates status of Inline Crypto Engine support.
> +
> +		== ============================
> +		0  Inline Crypto Engine can not be used.
> +		1  Inline Crypto Engine can be used.
> +		== ============================
> +
> +		The file is read only.

Why is this needed when /sys/block/$disk/queue/crypto/ already exists and
provides more information?

- Eric
