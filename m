Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F5F53CD98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 18:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344153AbiFCQ5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 12:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbiFCQ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 12:57:15 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADAD13E84;
        Fri,  3 Jun 2022 09:57:11 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 92AEC100003;
        Fri,  3 Jun 2022 16:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1654275430;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QZE9qS7TQkY684bsp1aOtO1TIYwTBearn5vIKQv58Zc=;
        b=BORFok4Mtr0Fzd56JjplsJYQ5nnKMlBm87bQ0CFW/MPvO4A67a+s5wuK3Vb7b6aagOQ9eA
        uCqZXPzFv1uKEV+9je4mjG4fRKjP0UTsWWekvdzrlu8Vt/Vb5FVdErmqkV1Lnhxh0uWy0M
        m++iKvsl/vmefO/rnocUtWyDxxU8jMyV+gKLuYWyl3MstfGlak/KjiYvcLd8xs0nfj6zDr
        uVuNX7Gig32mxWNC+g9Adc++kF8uQDH9C9ONbtqAhnyn/VvWa34sF/ODKeBrUee7thU6xI
        2ZvXOWmeNb5RiExfK6XP4OFQEnW1pow0tYKqIyjkq0SoOq04BaK/EHE7iV4SQw==
Date:   Fri, 3 Jun 2022 18:57:06 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     mani@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH] mtd: rawnand: qcom: Implement exec_op()
Message-ID: <20220603185706.55e85123@xps-13>
In-Reply-To: <1654273498-31998-1-git-send-email-quic_mdalam@quicinc.com>
References: <1654273498-31998-1-git-send-email-quic_mdalam@quicinc.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

quic_mdalam@quicinc.com wrote on Fri,  3 Jun 2022 21:54:58 +0530:

> Implement exec_op() so we can later get rid of the legacy interface
> implementation.

Thanks for doing this conversion!

>=20
> Co-developed-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 368 +++++++++++++++++++++-----------=
------
>  1 file changed, 204 insertions(+), 164 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index 048b255..507921b 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>  #include <linux/delay.h>
> +#include <linux/iopoll.h>
>  #include <linux/dma/qcom_bam_dma.h>
> =20
>  /* NANDc reg offsets */
> @@ -1305,15 +1306,13 @@ static int nandc_param(struct qcom_nand_host *hos=
t)
>  }
> =20
>  /* sets up descriptors for NAND_CMD_ERASE1 */
> -static int erase_block(struct qcom_nand_host *host, int page_addr)
> +static int erase_block(struct qcom_nand_host *host)
>  {
>  	struct nand_chip *chip =3D &host->chip;
>  	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> =20
>  	nandc_set_reg(chip, NAND_FLASH_CMD,
>  		      OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE);
> -	nandc_set_reg(chip, NAND_ADDR0, page_addr);
> -	nandc_set_reg(chip, NAND_ADDR1, 0);
>  	nandc_set_reg(chip, NAND_DEV0_CFG0,
>  		      host->cfg0_raw & ~(7 << CW_PER_PAGE));
>  	nandc_set_reg(chip, NAND_DEV0_CFG1, host->cfg1_raw);
> @@ -1321,14 +1320,8 @@ static int erase_block(struct qcom_nand_host *host=
, int page_addr)
>  	nandc_set_reg(chip, NAND_FLASH_STATUS, host->clrflashstatus);
>  	nandc_set_reg(chip, NAND_READ_STATUS, host->clrreadstatus);
> =20
> -	write_reg_dma(nandc, NAND_FLASH_CMD, 3, NAND_BAM_NEXT_SGL);
> +	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
>  	write_reg_dma(nandc, NAND_DEV0_CFG0, 2, NAND_BAM_NEXT_SGL);
> -	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> -
> -	read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> -
> -	write_reg_dma(nandc, NAND_FLASH_STATUS, 1, 0);
> -	write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
> =20
>  	return 0;
>  }
> @@ -1343,16 +1336,12 @@ static int read_id(struct qcom_nand_host *host, i=
nt column)
>  		return 0;
> =20
>  	nandc_set_reg(chip, NAND_FLASH_CMD, OP_FETCH_ID);
> -	nandc_set_reg(chip, NAND_ADDR0, column);
> -	nandc_set_reg(chip, NAND_ADDR1, 0);
>  	nandc_set_reg(chip, NAND_FLASH_CHIP_SELECT,
>  		      nandc->props->is_bam ? 0 : DM_EN);
>  	nandc_set_reg(chip, NAND_EXEC_CMD, 1);
> =20
> -	write_reg_dma(nandc, NAND_FLASH_CMD, 4, NAND_BAM_NEXT_SGL);
> -	write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> -
> -	read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
> +	write_reg_dma(nandc, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
> +	write_reg_dma(nandc, NAND_FLASH_CHIP_SELECT, 1, NAND_BAM_NEXT_SGL);
> =20
>  	return 0;
>  }
> @@ -1491,7 +1480,6 @@ static void parse_erase_write_errors(struct qcom_na=
nd_host *host, int command)
> =20
>  	for (i =3D 0; i < num_cw; i++) {
>  		u32 flash_status =3D le32_to_cpu(nandc->reg_read_buf[i]);
> -
>  		if (flash_status & FS_MPU_ERR)
>  			host->status &=3D ~NAND_STATUS_WP;
> =20
> @@ -1523,86 +1511,6 @@ static void post_command(struct qcom_nand_host *ho=
st, int command)
>  }
> =20
>  /*
> - * Implements chip->legacy.cmdfunc. It's  only used for a limited set of
> - * commands. The rest of the commands wouldn't be called by upper layers.
> - * For example, NAND_CMD_READOOB would never be called because we have o=
ur own
> - * versions of read_oob ops for nand_ecc_ctrl.
> - */
> -static void qcom_nandc_command(struct nand_chip *chip, unsigned int comm=
and,
> -			       int column, int page_addr)
> -{
> -	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> -	struct nand_ecc_ctrl *ecc =3D &chip->ecc;
> -	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> -	bool wait =3D false;
> -	int ret =3D 0;
> -
> -	pre_command(host, command);
> -
> -	switch (command) {
> -	case NAND_CMD_RESET:
> -		ret =3D reset(host);
> -		wait =3D true;
> -		break;
> -
> -	case NAND_CMD_READID:
> -		nandc->buf_count =3D 4;
> -		ret =3D read_id(host, column);
> -		wait =3D true;
> -		break;
> -
> -	case NAND_CMD_PARAM:
> -		ret =3D nandc_param(host);
> -		wait =3D true;
> -		break;
> -
> -	case NAND_CMD_ERASE1:
> -		ret =3D erase_block(host, page_addr);
> -		wait =3D true;
> -		break;
> -
> -	case NAND_CMD_READ0:
> -		/* we read the entire page for now */
> -		WARN_ON(column !=3D 0);
> -
> -		host->use_ecc =3D true;
> -		set_address(host, 0, page_addr);
> -		update_rw_regs(host, ecc->steps, true, 0);
> -		break;
> -
> -	case NAND_CMD_SEQIN:
> -		WARN_ON(column !=3D 0);
> -		set_address(host, 0, page_addr);
> -		break;
> -
> -	case NAND_CMD_PAGEPROG:
> -	case NAND_CMD_STATUS:
> -	case NAND_CMD_NONE:
> -	default:
> -		break;
> -	}
> -
> -	if (ret) {
> -		dev_err(nandc->dev, "failure executing command %d\n",
> -			command);
> -		free_descs(nandc);
> -		return;
> -	}
> -
> -	if (wait) {
> -		ret =3D submit_descs(nandc);
> -		if (ret)
> -			dev_err(nandc->dev,
> -				"failure submitting descs for command %d\n",
> -				command);
> -	}
> -
> -	free_descs(nandc);
> -
> -	post_command(host, command);
> -}
> -
> -/*
>   * when using BCH ECC, the HW flags an error in NAND_FLASH_STATUS if it =
read
>   * an erased CW, and reports an erased CW in NAND_ERASED_CW_DETECT_STATU=
S.
>   *
> @@ -2044,7 +1952,6 @@ static int qcom_nandc_read_page(struct nand_chip *c=
hip, uint8_t *buf,
>  	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
>  	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
>  	u8 *data_buf, *oob_buf =3D NULL;
> -
>  	nand_read_page_op(chip, page, 0, NULL, 0);
>  	data_buf =3D buf;
>  	oob_buf =3D oob_required ? chip->oob_poi : NULL;
> @@ -2366,64 +2273,6 @@ static int qcom_nandc_block_markbad(struct nand_ch=
ip *chip, loff_t ofs)
>  }
> =20
>  /*
> - * the three functions below implement chip->legacy.read_byte(),
> - * chip->legacy.read_buf() and chip->legacy.write_buf() respectively. th=
ese
> - * aren't used for reading/writing page data, they are used for smaller =
data
> - * like reading	id, status etc
> - */
> -static uint8_t qcom_nandc_read_byte(struct nand_chip *chip)
> -{
> -	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> -	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> -	u8 *buf =3D nandc->data_buffer;
> -	u8 ret =3D 0x0;
> -
> -	if (host->last_command =3D=3D NAND_CMD_STATUS) {
> -		ret =3D host->status;
> -
> -		host->status =3D NAND_STATUS_READY | NAND_STATUS_WP;
> -
> -		return ret;
> -	}
> -
> -	if (nandc->buf_start < nandc->buf_count)
> -		ret =3D buf[nandc->buf_start++];
> -
> -	return ret;
> -}
> -
> -static void qcom_nandc_read_buf(struct nand_chip *chip, uint8_t *buf, in=
t len)
> -{
> -	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> -	int real_len =3D min_t(size_t, len, nandc->buf_count - nandc->buf_start=
);
> -
> -	memcpy(buf, nandc->data_buffer + nandc->buf_start, real_len);
> -	nandc->buf_start +=3D real_len;
> -}
> -
> -static void qcom_nandc_write_buf(struct nand_chip *chip, const uint8_t *=
buf,
> -				 int len)
> -{
> -	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> -	int real_len =3D min_t(size_t, len, nandc->buf_count - nandc->buf_start=
);
> -
> -	memcpy(nandc->data_buffer + nandc->buf_start, buf, real_len);
> -
> -	nandc->buf_start +=3D real_len;
> -}
> -
> -/* we support only one external chip for now */
> -static void qcom_nandc_select_chip(struct nand_chip *chip, int chipnr)
> -{
> -	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> -
> -	if (chipnr <=3D 0)
> -		return;
> -
> -	dev_warn(nandc->dev, "invalid chip select\n");
> -}
> -
> -/*
>   * NAND controller page layout info
>   *
>   * Layout with ECC enabled:
> @@ -2738,8 +2587,207 @@ static int qcom_nand_attach_chip(struct nand_chip=
 *chip)
>  	return 0;
>  }
> =20
> +static int nandc_status(struct nand_chip *chip)
> +{
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> +
> +	memcpy(nandc->data_buffer, &host->status, 1);
> +
> +	return 0;
> +}
> +
> +static int qcom_nand_send_command(struct nand_chip *chip, u8 command)
> +{
> +	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	struct nand_ecc_ctrl *ecc =3D &chip->ecc;
> +
> +	int ret =3D 0;
> +
> +	pre_command(host, command);
> +
> +	switch (command) {
> +	case NAND_CMD_RESET:
> +		ret =3D reset(host);
> +		break;
> +	case NAND_CMD_READID:
> +		nandc->buf_count =3D 4;
> +		ret =3D read_id(host, 0);
> +		break;
> +	case NAND_CMD_PARAM:
> +		ret =3D nandc_param(host);
> +		break;
> +	case NAND_CMD_ERASE1:
> +		ret =3D erase_block(host);
> +		break;
> +	case NAND_CMD_STATUS:
> +		ret =3D nandc_status(chip);
> +		break;
> +	case NAND_CMD_READ0:
> +		host->use_ecc =3D true;

->exec_op() and ECC are orthogonal

> +		update_rw_regs(host, ecc->steps, true, 0);
> +		break;
> +	case NAND_CMD_ERASE2:
> +		break;
> +	case NAND_CMD_SEQIN:
> +		break;
> +	case NAND_CMD_PAGEPROG:
> +		break;

I am sorry but this is not following ->exec_op() main idea. The
controller is just here to forward requests to the device it must
respect a number of cycles but that's pretty much all. Here you are
actually re-writing ->cmdfunc() which is not what we expect.


> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_nand_send_address(struct nand_chip *chip,
> +				  const struct nand_op_instr *instr, int cmd)
> +{
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	u32 page_addr =3D 0x0, page_mask =3D 0x0;
> +
> +	page_addr =3D instr->ctx.addr.addrs[0];
> +
> +	/*
> +	 *Form page address for erase, read, write to using existing api
> +	 */
> +
> +	switch (cmd) {
> +	case NAND_CMD_ERASE1:
> +		page_addr =3D instr->ctx.addr.addrs[0];
> +		page_mask =3D instr->ctx.addr.addrs[1];
> +		page_mask <<=3D 8;
> +		page_addr =3D (page_addr | page_mask);
> +		page_mask =3D instr->ctx.addr.addrs[2];
> +		page_mask <<=3D 16;
> +		page_addr =3D (page_addr | page_mask);
> +		page_mask =3D instr->ctx.addr.addrs[3];
> +		page_mask <<=3D 24;
> +		page_addr =3D (page_addr | page_mask);
> +		break;
> +	case NAND_CMD_READ0:
> +	case NAND_CMD_SEQIN:
> +		page_addr =3D instr->ctx.addr.addrs[3];
> +		page_addr <<=3D 24;
> +		page_mask =3D instr->ctx.addr.addrs[2];
> +		page_mask <<=3D 16;
> +		page_addr |=3D page_mask;
> +		page_mask =3D instr->ctx.addr.addrs[1];
> +		page_mask <<=3D 8;
> +		page_addr |=3D page_mask;
> +		page_mask =3D instr->ctx.addr.addrs[0];
> +		page_addr |=3D page_mask;

Same here, just write the number of address cycles that were requested
by the core.

> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (cmd =3D=3D NAND_CMD_PARAM)
> +		return 0;
> +
> +	nandc_set_reg(chip, NAND_ADDR0, page_addr);
> +	nandc_set_reg(chip, NAND_ADDR1, 0);
> +
> +	if (cmd !=3D NAND_CMD_SEQIN)
> +		write_reg_dma(nandc, NAND_ADDR0, 2, 0);
> +
> +	return 0;
> +}
> +
> +static void qcom_nand_read_buf(struct nand_chip *chip, u8 *buf, int len)
> +{
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +
> +	memcpy(buf, nandc->data_buffer, len);

Is this bounce buffer needed?

> +}
> +
> +static int qcom_nand_exec_instr(struct nand_chip *chip,
> +				const struct nand_op_instr *instr)
> +{
> +	struct qcom_nand_controller *nandc =3D get_qcom_nand_controller(chip);
> +	struct qcom_nand_host *host =3D to_qcom_nand_host(chip);
> +	u32 status;
> +	int ret =3D 0;
> +	bool wait =3D false;
> +	static int opcode;
> +
> +	switch (instr->type) {
> +	case NAND_OP_CMD_INSTR:
> +		ret =3D qcom_nand_send_command(chip, instr->ctx.cmd.opcode);
> +		if (instr->ctx.cmd.opcode =3D=3D NAND_CMD_RESET)
> +			wait =3D true;
> +		opcode =3D instr->ctx.cmd.opcode;
> +		break;
> +	case NAND_OP_ADDR_INSTR:
> +		qcom_nand_send_address(chip, instr, opcode);
> +		if (opcode !=3D NAND_CMD_READ0 && opcode !=3D NAND_CMD_READSTART &&
> +		    opcode !=3D NAND_CMD_PARAM && opcode !=3D NAND_CMD_SEQIN)
> +			wait =3D true;
> +		break;
> +	case NAND_OP_DATA_IN_INSTR:
> +		qcom_nand_read_buf(chip, instr->ctx.data.buf.in, instr->ctx.data.len);
> +		break;
> +	case NAND_OP_DATA_OUT_INSTR:
> +		wait =3D false;
> +		break;
> +	case NAND_OP_WAITRDY_INSTR:
> +		ret =3D readl_poll_timeout(nandc->base + NAND_FLASH_STATUS, status,
> +					 (status & FS_READY_BSY_N), 20,
> +					 instr->ctx.waitrdy.timeout_ms * 1000);
> +		if (opcode =3D=3D NAND_CMD_PARAM)
> +			wait =3D true;
> +	default:
> +		break;
> +	}
> +
> +	if (wait) {
> +		if (opcode !=3D NAND_CMD_PARAM)
> +			write_reg_dma(nandc, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
> +
> +		if (opcode =3D=3D NAND_CMD_READID)
> +			read_reg_dma(nandc, NAND_READ_ID, 1, NAND_BAM_NEXT_SGL);
> +
> +		if (opcode =3D=3D NAND_CMD_ERASE1) {
> +			read_reg_dma(nandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
> +			write_reg_dma(nandc, NAND_FLASH_STATUS, 1, 0);
> +			write_reg_dma(nandc, NAND_READ_STATUS, 1, NAND_BAM_NEXT_SGL);
> +		}
> +
> +		ret =3D submit_descs(nandc);
> +		if (ret)
> +			dev_err(nandc->dev, "failure submitting descs for command 0x%02x\n",
> +				opcode);
> +
> +		free_descs(nandc);
> +		post_command(host, opcode);
> +	}
> +
> +	return ret;
> +}
> +
> +static int qcom_nand_exec_op(struct nand_chip *chip,
> +			     const struct nand_operation *op,
> +				bool check_only)
> +{
> +	unsigned int i;
> +	int ret =3D 0;
> +
> +	if (check_only)
> +		return 0;
> +
> +	for (i =3D 0; i < op->ninstrs; i++) {
> +		ret =3D qcom_nand_exec_instr(chip, &op->instrs[i]);
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
>  static const struct nand_controller_ops qcom_nandc_ops =3D {
>  	.attach_chip =3D qcom_nand_attach_chip,
> +	.exec_op =3D qcom_nand_exec_op,
>  };
> =20
>  static void qcom_nandc_unalloc(struct qcom_nand_controller *nandc)
> @@ -2938,14 +2986,6 @@ static int qcom_nand_host_init_and_register(struct=
 qcom_nand_controller *nandc,
>  	mtd->owner =3D THIS_MODULE;
>  	mtd->dev.parent =3D dev;
> =20
> -	chip->legacy.cmdfunc	=3D qcom_nandc_command;
> -	chip->legacy.select_chip	=3D qcom_nandc_select_chip;
> -	chip->legacy.read_byte	=3D qcom_nandc_read_byte;
> -	chip->legacy.read_buf	=3D qcom_nandc_read_buf;
> -	chip->legacy.write_buf	=3D qcom_nandc_write_buf;
> -	chip->legacy.set_features	=3D nand_get_set_features_notsupp;
> -	chip->legacy.get_features	=3D nand_get_set_features_notsupp;
> -
>  	/*
>  	 * the bad block marker is readable only when we read the last codeword
>  	 * of a page with ECC disabled. currently, the nand_base and nand_bbt


Thanks,
Miqu=C3=A8l
