Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1AC34ACE67
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 02:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbiBHBun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 20:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344798AbiBHBkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 20:40:31 -0500
Received: from relay3.hostedemail.com (relay3.hostedemail.com [64.99.140.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EEFC061A73
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 17:40:30 -0800 (PST)
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay06.hostedemail.com (Postfix) with ESMTP id 3E6E02282B;
        Tue,  8 Feb 2022 01:40:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id EAB782D;
        Tue,  8 Feb 2022 01:40:12 +0000 (UTC)
Message-ID: <103681860759d72b1acf712eed334b1d4ef6b7d5.camel@perches.com>
Subject: Re: [PATCH V6 1/3] platform/x86: Add Intel Software Defined Silicon
 driver
From:   Joe Perches <joe@perches.com>
To:     "David E. Box" <david.e.box@linux.intel.com>, hdegoede@redhat.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Date:   Mon, 07 Feb 2022 17:40:26 -0800
In-Reply-To: <20220208005444.487209-2-david.e.box@linux.intel.com>
References: <20220208005444.487209-1-david.e.box@linux.intel.com>
         <20220208005444.487209-2-david.e.box@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: EAB782D
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: cqp3gnqhxdfm9599fkk1o4kd3ab9ky5j
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/rw6BEZ0kR964qVgcoew+I17VtKpWRSzg=
X-HE-Tag: 1644284412-993389
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-07 at 16:54 -0800, David E. Box wrote:
> Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> activating additional silicon features. Features are enabled through a
> license activation process.  The SDSi driver provides a per socket, sysfs
> attribute interface for applications to perform 3 main provisioning
> functions:
[]
> ---
> V6
>   - Replace,
>               return (ret < 0) ? ret : size;
>     with,
>               if (ret)
>                    return ret;
>               return size
> 
>     Besides the style change (suggested by GKH) this fixes a klocwork
>     warning.

thanks.

> diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c

[]

> +/* SDSi mailbox operations must be performed using 64bit mov instructions */
> +static __always_inline void
> +sdsi_memcpy64_toio(u64 __iomem *to, const u64 *from, size_t count_bytes)
> +{
> +	size_t count = count_bytes / sizeof(*to);
> +	int i;
> +
> +	for (i = 0; i < count; i++)
> +		writeq(from[i], &to[i]);

Any chance the byte count is not a multiple of sizeof(u64) ?

> +static __always_inline void
> +sdsi_memcpy64_fromio(u64 *to, const u64 __iomem *from, size_t count_bytes)
> +{
> +	size_t count = count_bytes / sizeof(*to);
> +	int i;
> +
> +	for (i = 0; i < count; i++)
> +		to[i] = readq(&from[i]);
> +}

here too.

[]

> +static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
> +			      size_t *data_size)
> +{
> +	struct device *dev = priv->dev;
> +	u32 total, loop, eom, status, message_size;
[]
> +		if (packet_size > SDSI_SIZE_MAILBOX) {
> +			dev_err(dev, "Packet size to large\n");

too

[]
> +	/* Message size check is only valid for multi-packet transfers */
> +	if (loop && total != message_size)
> +		dev_warn(dev, "Read count %d differs from expected count %d\n",

%u

> +			 total, message_size);


> +static int sdsi_map_mbox_registers(struct sdsi_priv *priv, struct pci_dev *parent,
> +				   struct disc_table *disc_table, struct resource *disc_res)
> +{
> +	u32 access_type = FIELD_GET(DT_ACCESS_TYPE, disc_table->access_info);
> +	u32 size = FIELD_GET(DT_SIZE, disc_table->access_info);
> +	u32 tbir = FIELD_GET(DT_TBIR, disc_table->offset);
> +	u32 offset = DT_OFFSET(disc_table->offset);
> +	u32 features_offset;
> +	struct resource res = {};
> +
> +	/* Starting location of SDSi MMIO region based on access type */
> +	switch (access_type) {
> +	case ACCESS_TYPE_LOCAL:
> +		if (tbir) {
> +			dev_err(priv->dev, "Unsupported BAR index %d for access type %d\n",
> +				tbir, access_type);

%u here too

[]
> +		dev_err(priv->dev, "Unrecognized access_type %d\n", access_type);

and here


