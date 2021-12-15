Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1193C475045
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 02:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238908AbhLOBFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 20:05:19 -0500
Received: from twspam01.aspeedtech.com ([211.20.114.71]:40139 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239107AbhLOBEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 20:04:40 -0500
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1BF0dDeu017400;
        Wed, 15 Dec 2021 08:39:13 +0800 (GMT-8)
        (envelope-from jammy_huang@aspeedtech.com)
Received: from [192.168.2.115] (192.168.2.115) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Dec
 2021 09:04:35 +0800
Message-ID: <387e8181-c943-9372-48b1-3caadac4caac@aspeedtech.com>
Date:   Wed, 15 Dec 2021 09:04:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] media: aspeed: Use runtime configuration
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     "eajames@linux.ibm.com" <eajames@linux.ibm.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20211207015544.1755-1-jammy_huang@aspeedtech.com>
 <20211214161216.607df557@coco.lan>
From:   Jammy Huang <jammy_huang@aspeedtech.com>
In-Reply-To: <20211214161216.607df557@coco.lan>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.2.115]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1BF0dDeu017400
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

OK, I didn't notice previouso one has been applied.
Thank you.

On 2021/12/14 下午 11:12, Mauro Carvalho Chehab wrote:
> Hi Jammy,
>
> A different version of this patch was already applied. If it still makes
> change, please rebase this one on the top of the media upstream and
> re-send.
>
> Thanks,
> Mauro
>
> Em Tue, 7 Dec 2021 09:55:44 +0800
> Jammy Huang <jammy_huang@aspeedtech.com> escreveu:
>
>> The aspeed video IP has some differences between SoC families. Currently
>> the driver decides which registers to use at compile time, which means
>> a single kernel can not be used between platforms.
>>
>> Switch to using runtime configuration of the registers that vary between
>> SoC families.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
>> ---
>>   drivers/media/platform/aspeed-video.c | 71 ++++++++++++++++++++-------
>>   1 file changed, 52 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
>> index d2335d669fb3..ba8ee82b38c3 100644
>> --- a/drivers/media/platform/aspeed-video.c
>> +++ b/drivers/media/platform/aspeed-video.c
>> @@ -75,11 +75,8 @@
>>   #define  VE_SEQ_CTRL_CAP_BUSY		BIT(16)
>>   #define  VE_SEQ_CTRL_COMP_BUSY		BIT(18)
>>   
>> -#ifdef CONFIG_MACH_ASPEED_G4
>> -#define  VE_SEQ_CTRL_JPEG_MODE		BIT(8)	/* AST2400 */
>> -#else
>> -#define  VE_SEQ_CTRL_JPEG_MODE		BIT(13)	/* AST2500/2600 */
>> -#endif
>> +#define AST2500_VE_SEQ_CTRL_JPEG_MODE	BIT(13)
>> +#define AST2400_VE_SEQ_CTRL_JPEG_MODE	BIT(8)
>>   
>>   #define VE_CTRL				0x008
>>   #define  VE_CTRL_HSYNC_POL		BIT(0)
>> @@ -136,9 +133,8 @@
>>   #define  VE_COMP_CTRL_HQ_DCT_CHR	GENMASK(26, 22)
>>   #define  VE_COMP_CTRL_HQ_DCT_LUM	GENMASK(31, 27)
>>   
>> -#define VE_OFFSET_COMP_STREAM		0x078
>> -
>> -#define VE_JPEG_COMP_SIZE_READ_BACK	0x084
>> +#define AST2400_VE_COMP_SIZE_READ_BACK	0x078
>> +#define AST2600_VE_COMP_SIZE_READ_BACK	0x084
>>   
>>   #define VE_SRC_LR_EDGE_DET		0x090
>>   #define  VE_SRC_LR_EDGE_DET_LEFT	GENMASK(11, 0)
>> @@ -233,6 +229,8 @@ struct aspeed_video {
>>   	struct video_device vdev;
>>   	struct mutex video_lock;	/* v4l2 and videobuf2 lock */
>>   
>> +	struct aspeed_video_config config;
>> +
>>   	wait_queue_head_t wait;
>>   	spinlock_t lock;		/* buffer list lock */
>>   	struct delayed_work res_work;
>> @@ -258,6 +256,30 @@ struct aspeed_video {
>>   
>>   #define to_aspeed_video(x) container_of((x), struct aspeed_video, v4l2_dev)
>>   
>> +struct aspeed_video_config {
>> +	u32 version;
>> +	u32 jpeg_mode;
>> +	u32 comp_size_read;
>> +};
>> +
>> +static const struct aspeed_video_config ast2400_config = {
>> +	.version = 4,
>> +	.jpeg_mode = AST2400_VE_SEQ_CTRL_JPEG_MODE,
>> +	.comp_size_read = AST2400_VE_COMP_SIZE_READ_BACK,
>> +};
>> +
>> +static const struct aspeed_video_config ast2500_config = {
>> +	.version = 5,
>> +	.jpeg_mode = AST2500_VE_SEQ_CTRL_JPEG_MODE,
>> +	.comp_size_read = AST2400_VE_COMP_SIZE_READ_BACK,
>> +};
>> +
>> +static const struct aspeed_video_config ast2600_config = {
>> +	.version = 6,
>> +	.jpeg_mode = AST2500_VE_SEQ_CTRL_JPEG_MODE,
>> +	.comp_size_read = AST2600_VE_COMP_SIZE_READ_BACK,
>> +};
>> +
>>   static const u32 aspeed_video_jpeg_header[ASPEED_VIDEO_JPEG_HEADER_SIZE] = {
>>   	0xe0ffd8ff, 0x464a1000, 0x01004649, 0x60000101, 0x00006000, 0x0f00feff,
>>   	0x00002d05, 0x00000000, 0x00000000, 0x00dbff00
>> @@ -640,7 +662,7 @@ static irqreturn_t aspeed_video_irq(int irq, void *arg)
>>   	if (sts & VE_INTERRUPT_COMP_COMPLETE) {
>>   		struct aspeed_video_buffer *buf;
>>   		u32 frame_size = aspeed_video_read(video,
>> -						   VE_JPEG_COMP_SIZE_READ_BACK);
>> +						   video->config.comp_size_read);
>>   
>>   		update_perf(&video->perf);
>>   
>> @@ -973,7 +995,7 @@ static void aspeed_video_update_regs(struct aspeed_video *video)
>>   		FIELD_PREP(VE_COMP_CTRL_DCT_LUM, video->jpeg_quality) |
>>   		FIELD_PREP(VE_COMP_CTRL_DCT_CHR, video->jpeg_quality | 0x10);
>>   	u32 ctrl = 0;
>> -	u32 seq_ctrl = VE_SEQ_CTRL_JPEG_MODE;
>> +	u32 seq_ctrl = video->config.jpeg_mode;
>>   
>>   	v4l2_dbg(1, debug, &video->v4l2_dev, "framerate(%d)\n",
>>   		 video->frame_rate);
>> @@ -993,7 +1015,7 @@ static void aspeed_video_update_regs(struct aspeed_video *video)
>>   
>>   	/* Set control registers */
>>   	aspeed_video_update(video, VE_SEQ_CTRL,
>> -			    VE_SEQ_CTRL_JPEG_MODE | VE_SEQ_CTRL_YUV420,
>> +			    video->config.jpeg_mode | VE_SEQ_CTRL_YUV420,
>>   			    seq_ctrl);
>>   	aspeed_video_update(video, VE_CTRL, VE_CTRL_FRC, ctrl);
>>   	aspeed_video_update(video, VE_COMP_CTRL,
>> @@ -1790,8 +1812,18 @@ static int aspeed_video_init(struct aspeed_video *video)
>>   	return rc;
>>   }
>>   
>> +static const struct of_device_id aspeed_video_of_match[] = {
>> +	{ .compatible = "aspeed,ast2400-video-engine", .data = &ast2400_config },
>> +	{ .compatible = "aspeed,ast2500-video-engine", .data = &ast2500_config },
>> +	{ .compatible = "aspeed,ast2600-video-engine", .data = &ast2600_config },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, aspeed_video_of_match);
>> +
>>   static int aspeed_video_probe(struct platform_device *pdev)
>>   {
>> +	const struct aspeed_video_config *config;
>> +	const struct of_device_id *match;
>>   	int rc;
>>   	struct resource *res;
>>   	struct aspeed_video *video =
>> @@ -1815,6 +1847,13 @@ static int aspeed_video_probe(struct platform_device *pdev)
>>   	if (IS_ERR(video->base))
>>   		return PTR_ERR(video->base);
>>   
>> +	match = of_match_node(aspeed_video_of_match, pdev->dev.of_node);
>> +	if (!match)
>> +		return -EINVAL;
>> +
>> +	config = match->data;
>> +	video->config = *config;
>> +
>>   	rc = aspeed_video_init(video);
>>   	if (rc)
>>   		return rc;
>> @@ -1828,6 +1867,8 @@ static int aspeed_video_probe(struct platform_device *pdev)
>>   
>>   	aspeed_video_debugfs_create(video);
>>   
>> +	dev_info(video->dev, "compatible for g%d\n", config->version);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1860,14 +1901,6 @@ static int aspeed_video_remove(struct platform_device *pdev)
>>   	return 0;
>>   }
>>   
>> -static const struct of_device_id aspeed_video_of_match[] = {
>> -	{ .compatible = "aspeed,ast2400-video-engine" },
>> -	{ .compatible = "aspeed,ast2500-video-engine" },
>> -	{ .compatible = "aspeed,ast2600-video-engine" },
>> -	{}
>> -};
>> -MODULE_DEVICE_TABLE(of, aspeed_video_of_match);
>> -
>>   static struct platform_driver aspeed_video_driver = {
>>   	.driver = {
>>   		.name = DEVICE_NAME,
>
>
> Thanks,
> Mauro

-- 
Best Regards
Jammy

