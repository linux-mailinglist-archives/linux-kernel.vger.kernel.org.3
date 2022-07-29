Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F11E5851C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbiG2Oqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiG2Oq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:46:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63815A8BA
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659105989; x=1690641989;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=m9Ot69f7v52GIgFR648kODiHS1IQPN1bSG6GxWTY8lI=;
  b=YVIPDkVM1acsq57MoYr41bk+OFvqI3NyusHSp1FQiz1iZuuXb6z/lKXL
   fguwstV61BYRFPSmo3NUaGgVDkBohcbu+f1+LRX0ZfmlfstKYzQy7n83x
   aKwHrQqw3Lw8BOyDI0HoP+eaOsCsXhfaQG3zjM5ulm5O5Kwgo7bejWkxH
   0M7CCKpAX2Yl1eAkHDLvrpgDzL6b+37dv+Jg92xJAODnBkNGZdhgWkhXS
   g4rXQXOG7TGJ1EPi0uAebmIFLw3c7r3y48imRiY1S8nX81JIG/vxcGwH3
   1aPaqKsrx2YVSiOjOgKz7uXGJOKQ7rIPTeAQ+10ebWrBFL5iObsO5mdiu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="271819944"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="271819944"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:46:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="604982775"
Received: from kaholo-mobl.amr.corp.intel.com (HELO [10.212.97.86]) ([10.212.97.86])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 07:46:27 -0700
Message-ID: <9365e038-2146-98f8-f989-02827f221c34@linux.intel.com>
Date:   Fri, 29 Jul 2022 09:46:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 2/5] soundwire: sysfs: cleanup the logic for creating the
 dp0 sysfs attributes
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
References: <20220729135041.2285908-1-gregkh@linuxfoundation.org>
 <20220729135041.2285908-2-gregkh@linuxfoundation.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220729135041.2285908-2-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/29/22 08:50, Greg Kroah-Hartman wrote:
> There's no need to special-case the dp0 sysfs attributes, the
> is_visible() callback in the attribute group can handle that for us, so
> add that and add it to the attribute group list making the logic simpler
> overall.
> 
> This is a step on the way to moving all of the sysfs attribute handling
> into the default driver core attribute group logic so that the soundwire
> core does not have to do any of it manually.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Sanyog Kale <sanyog.r.kale@intel.com>
> Cc: alsa-devel@alsa-project.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/soundwire/sysfs_slave.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
> index 83e3f6cc3250..3723333a5c2b 100644
> --- a/drivers/soundwire/sysfs_slave.c
> +++ b/drivers/soundwire/sysfs_slave.c
> @@ -174,6 +174,16 @@ static ssize_t words_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(words);
>  
> +static umode_t dp0_is_visible(struct kobject *kobj, struct attribute *attr,
> +			      int n)
> +{
> +	struct sdw_slave *slave = dev_to_sdw_dev(kobj_to_dev(kobj));
> +
> +	if (slave->prop.dp0_prop)
> +		return attr->mode;
> +	return 0;
> +}

This changes the results slightly by creating an empty 'dp0' directory
with no attributes inside.

Before:

[root@fedora ~]# cd /sys/bus/soundwire/devices/sdw:3:025d:0714:01
[root@fedora sdw:3:025d:0714:01]# ls dp0
ls: cannot access 'dp0': No such file or directory

After:
[root@fedora sdw:3:025d:0714:01]# ls dp0

> +
>  static struct attribute *dp0_attrs[] = {
>  	&dev_attr_max_word.attr,
>  	&dev_attr_min_word.attr,
> @@ -190,12 +200,14 @@ static struct attribute *dp0_attrs[] = {
>   */
>  static const struct attribute_group dp0_group = {
>  	.attrs = dp0_attrs,
> +	.is_visible = dp0_is_visible,
>  	.name = "dp0",
>  };
>  
>  static const struct attribute_group *slave_groups[] = {
>  	&slave_attr_group,
>  	&sdw_slave_dev_attr_group,
> +	&dp0_group,
>  	NULL,
>  };
>  
> @@ -207,12 +219,6 @@ int sdw_slave_sysfs_init(struct sdw_slave *slave)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (slave->prop.dp0_prop) {
> -		ret = devm_device_add_group(&slave->dev, &dp0_group);
> -		if (ret < 0)
> -			return ret;
> -	}
> -
>  	if (slave->prop.source_ports || slave->prop.sink_ports) {
>  		ret = sdw_slave_sysfs_dpn_init(slave);
>  		if (ret < 0)
