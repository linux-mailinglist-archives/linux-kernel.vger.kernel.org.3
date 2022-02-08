Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27314ACF3F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346229AbiBHCys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346242AbiBHCyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:54:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E8C0401C9;
        Mon,  7 Feb 2022 18:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644288881; x=1675824881;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6IOSsvUamZzHAOJQun2LOjMi6FELRZcH68wuHsOsUKg=;
  b=VfNoYJkEWO6vgZ/FQAljDNnbIW+fngDkwjTykJJ4vyewirdEU1NJgxpn
   5ZjuKYCDH2TVDZkb3836EH3ZDIbJL5uLXIy6hZKEjU2Hd6ClAEPciybrM
   LYUWnnPlurAXzZ4uMJXX1n9l/+9q1YhbcM4RAIqORTFXMwJTMN6CWfnh4
   TuFCYM6t7uzHxQgmElb4yu3bzdgng0iAj8jbBnSOhyry2WYdqc0Frz3BG
   YynKlcf8UNfxc4zPoy7F+qXz2R/LAyEBpD4Vybxv6n7KIBcihse3uwpCP
   amsvKLCGhHQbQVMrwYrvgJZoofXQp8OUxT4Io1Z8ImogLb382M0jWmu5Z
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="246447942"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="246447942"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 18:54:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="585044998"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 07 Feb 2022 18:54:40 -0800
Received: from cbaldes-mobl.amr.corp.intel.com (unknown [10.212.183.65])
        by linux.intel.com (Postfix) with ESMTP id 9A693580970;
        Mon,  7 Feb 2022 18:54:40 -0800 (PST)
Message-ID: <d52b50f3b704280e476e60417323c98f45baf54a.camel@linux.intel.com>
Subject: Re: [PATCH V6 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Joe Perches <joe@perches.com>, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Mon, 07 Feb 2022 18:54:40 -0800
In-Reply-To: <103681860759d72b1acf712eed334b1d4ef6b7d5.camel@perches.com>
References: <20220208005444.487209-1-david.e.box@linux.intel.com>
         <20220208005444.487209-2-david.e.box@linux.intel.com>
         <103681860759d72b1acf712eed334b1d4ef6b7d5.camel@perches.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-07 at 17:40 -0800, Joe Perches wrote:
> On Mon, 2022-02-07 at 16:54 -0800, David E. Box wrote:
> > Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> > activating additional silicon features. Features are enabled through a
> > license activation process.  The SDSi driver provides a per socket, sysfs
> > attribute interface for applications to perform 3 main provisioning
> > functions:
> []
> > ---
> > V6
> >   - Replace,
> >               return (ret < 0) ? ret : size;
> >     with,
> >               if (ret)
> >                    return ret;
> >               return size
> > 
> >     Besides the style change (suggested by GKH) this fixes a klocwork
> >     warning.
> 
> thanks.
> 
> > diff --git a/drivers/platform/x86/intel/sdsi.c
> > b/drivers/platform/x86/intel/sdsi.c
> 
> []
> 
> > +/* SDSi mailbox operations must be performed using 64bit mov instructions
> > */
> > +static __always_inline void
> > +sdsi_memcpy64_toio(u64 __iomem *to, const u64 *from, size_t count_bytes)
> > +{
> > +	size_t count = count_bytes / sizeof(*to);
> > +	int i;
> > +
> > +	for (i = 0; i < count; i++)
> > +		writeq(from[i], &to[i]);
> 
> Any chance the byte count is not a multiple of sizeof(u64) ?

No. The value passed to count_bytes is either u64 or rounded up to sizeof(u64).
But I'd like to know how I could guard against accidentally passing something
different in the future.

Andy had suggested just adding support for 64 bit memcpy io, but I hadn't time
to look at this.

> 
> > +static __always_inline void
> > +sdsi_memcpy64_fromio(u64 *to, const u64 __iomem *from, size_t count_bytes)
> > +{
> > +	size_t count = count_bytes / sizeof(*to);
> > +	int i;
> > +
> > +	for (i = 0; i < count; i++)
> > +		to[i] = readq(&from[i]);
> > +}
> 
> here too.

Same.

> 
> []
> 
> > +static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info
> > *info,
> > +			      size_t *data_size)
> > +{
> > +	struct device *dev = priv->dev;
> > +	u32 total, loop, eom, status, message_size;
> []
> > +		if (packet_size > SDSI_SIZE_MAILBOX) {
> > +			dev_err(dev, "Packet size to large\n");
> 
> too

Sorry, I'm missing the question here. If it's whether packet_size could also not
be a multiple of sizeof(u64) the answer here is yes. But I don't see how that
matters. packet_size is a value read from the hardware. This is just a sanity
check.

> 
> []
> > +	/* Message size check is only valid for multi-packet transfers */
> > +	if (loop && total != message_size)
> > +		dev_warn(dev, "Read count %d differs from expected count %d\n",
> 
> %u
> 
> > +			 total, message_size);
> > +static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev
> > *parent,
> > +				   struct disc_table *disc_table, struct
> > resource *disc_res)
> > +{
> > +	u32 access_type = FIELD_GET(DT_ACCESS_TYPE, disc_table->access_info);
> > +	u32 size = FIELD_GET(DT_SIZE, disc_table->access_info);
> > +	u32 tbir = FIELD_GET(DT_TBIR, disc_table->offset);
> > +	u32 offset = DT_OFFSET(disc_table->offset);
> > +	u32 features_offset;
> > +	struct resource res = {};
> > +
> > +	/* Starting location of SDSi MMIO region based on access type */
> > +	switch (access_type) {
> > +	case ACCESS_TYPE_LOCAL:
> > +		if (tbir) {
> > +			dev_err(priv->dev, "Unsupported BAR index %d for access
> > type %d\n",
> > +				tbir, access_type);
> 
> %u here too
> 
> []
> > +		dev_err(priv->dev, "Unrecognized access_type %d\n",
> > access_type);
> 
> and here

Ack on the specifier changes. Thanks.

> 
> 

