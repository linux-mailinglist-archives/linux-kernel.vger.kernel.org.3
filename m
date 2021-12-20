Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C8747A59D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 09:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234759AbhLTIBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 03:01:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39468 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbhLTIBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 03:01:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56612B80DE4;
        Mon, 20 Dec 2021 08:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EDB6C36AE5;
        Mon, 20 Dec 2021 08:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639987306;
        bh=X12VmBknicVjgbv7HxmJD8uGDh8s2z+dy+9umzmV/Xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkm1RE4ijQ7apagXaTZyMIblVTPyjgANwhdGS9Iz7ZoTDTQRGeScbOZ+RID3jOzbH
         af4jkFFL7fCI2DeOX5qdoMG69vfKfCcVUwJO9A4GLf/TNHMtiymLeLklA4ztDFWi9F
         8j8OCLsEZnJ6vmiCOAYWITRA8WdKrMUzmTKiEekc=
Date:   Mon, 20 Dec 2021 09:01:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] sysfs: add sysfs_add_bin_file_to_group()
Message-ID: <YcA4Zrg0qSqYaVL6@kroah.com>
References: <20211220064730.28806-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211220064730.28806-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 07:47:29AM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> There already is sysfs_add_file_to_group() for adding "attribute" to a
> group. This new function allows adding "bin_attribute" as well.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  fs/sysfs/file.c       | 31 +++++++++++++++++++++++++++----
>  include/linux/sysfs.h |  3 +++
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 42dcf96881b6..30c798c38d89 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -376,14 +376,19 @@ EXPORT_SYMBOL_GPL(sysfs_create_files);
>   * @attr: attribute descriptor.
>   * @group: group name.
>   */
> -int sysfs_add_file_to_group(struct kobject *kobj,
> -		const struct attribute *attr, const char *group)
> +int __sysfs_add_file_to_group(struct kobject *kobj,
> +			      const struct attribute *attr,
> +			      const struct bin_attribute *battr,
> +			      const char *group)
>  {
>  	struct kernfs_node *parent;
>  	kuid_t uid;
>  	kgid_t gid;
>  	int error;
>  
> +	if (WARN_ON((attr && battr) || (!attr && !battr)))
> +		return -EINVAL;

How can this ever happen?

