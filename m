Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC112484496
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiADPbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:31:07 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60964 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiADPbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:31:05 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6087F1F42827;
        Tue,  4 Jan 2022 15:31:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641310263;
        bh=A6BNDFgzCCR2SKuRgncJXj6E9yuE9xrAsob6k7BoQ7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IhpGsOwEEkOrG+LVj2gC1rN4+fzHwzjsR8EcwB5QqKJQSxsGzjZBrY9DBzxcKS9US
         ueLMxWiQSDEm9pOXKY99I+NwB1nCk4Pv/dAFv0iasOJ6GkuXNzmDhcoNl9ZRJYPlHs
         ShQrWdELHOxcfiK7Y3OwbANltJZ2rNPKu3QcR/Lxv/tUVcmTE5v6GPgJorbQxbmLOt
         ATKtm2AoikfM+jAqePyyGGq5dY0RhrdFiccNI6iAVCzqKOyBL29rM9VGgw2wdKnT74
         dI4U4f0cGmzk20dnZ4ydiIUa99aMZDcp3LBhaGVTVHHuW4e6hgjkDUJoQgzpel9NwG
         9dFiiz2+5AXag==
Date:   Tue, 4 Jan 2022 16:31:00 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>
Subject: Re: [PATCH v3 01/17] spi: spi-mem: Add DTR templates for cmd,
 address, dummy and data phase
Message-ID: <20220104163100.56850d0b@collabora.com>
In-Reply-To: <20220101074250.14443-2-a-nandan@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-2-a-nandan@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jan 2022 13:12:34 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> Setting dtr field of spi_mem_op is useful when creating templates
> for DTR ops in spinand.h. Also, 2 bytes cmd phases are required when
> operating in Octal DTR SPI mode.
> 
> Create new templates for dtr mode cmd, address, dummy and data phase
> in spi_mem_op, which set the dtr field to 1 and also allow passing
> the nbytes for the cmd phase.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  include/linux/spi/spi-mem.h | 41 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index 85e2ff7b840d..682378a9c600 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -20,6 +20,14 @@
>  		.nbytes = 1,					\
>  	}
>  
> +#define SPI_MEM_OP_CMD_DTR(__nbytes, __opcode, __buswidth)	\
> +	{							\
> +		.nbytes = __nbytes,				\
> +		.opcode = __opcode,				\
> +		.buswidth = __buswidth,				\
> +		.dtr = 1,					\
> +	}
> +
>  #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
>  	{							\
>  		.nbytes = __nbytes,				\
> @@ -27,6 +35,14 @@
>  		.buswidth = __buswidth,				\
>  	}
>  
> +#define SPI_MEM_OP_ADDR_DTR(__nbytes, __val, __buswidth)	\
> +	{							\
> +		.nbytes = __nbytes,				\
> +		.val = __val,					\
> +		.buswidth = __buswidth,				\
> +		.dtr = 1,					\
> +	}
> +
>  #define SPI_MEM_OP_NO_ADDR	{ }
>  
>  #define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)			\
> @@ -35,6 +51,13 @@
>  		.buswidth = __buswidth,				\
>  	}
>  
> +#define SPI_MEM_OP_DUMMY_DTR(__nbytes, __buswidth)		\
> +	{							\
> +		.nbytes = __nbytes,				\
> +		.buswidth = __buswidth,				\
> +		.dtr = 1,					\
> +	}
> +
>  #define SPI_MEM_OP_NO_DUMMY	{ }
>  
>  #define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)		\
> @@ -45,6 +68,15 @@
>  		.buswidth = __buswidth,				\
>  	}
>  
> +#define SPI_MEM_OP_DATA_IN_DTR(__nbytes, __buf, __buswidth)	\
> +	{							\
> +		.dir = SPI_MEM_DATA_IN,				\
> +		.nbytes = __nbytes,				\
> +		.buf.in = __buf,				\
> +		.buswidth = __buswidth,				\
> +		.dtr = 1,					\
> +	}
> +
>  #define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)	\
>  	{							\
>  		.dir = SPI_MEM_DATA_OUT,			\
> @@ -53,6 +85,15 @@
>  		.buswidth = __buswidth,				\
>  	}
>  
> +#define SPI_MEM_OP_DATA_OUT_DTR(__nbytes, __buf, __buswidth)	\
> +	{							\
> +		.dir = SPI_MEM_DATA_OUT,			\
> +		.nbytes = __nbytes,				\
> +		.buf.out = __buf,				\
> +		.buswidth = __buswidth,				\
> +		.dtr = 1,					\
> +	}
> +
>  #define SPI_MEM_OP_NO_DATA	{ }
>  
>  /**

How about:

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 85e2ff7b840d..9a8d42803026 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -13,44 +13,59 @@
 
 #include <linux/spi/spi.h>
 
-#define SPI_MEM_OP_CMD(__opcode, __buswidth)                   \
+#define SPI_MEM_OP_DTR .dtr = 1
+
+#define SPI_MEM_OP_CMD(__opcode, __buswidth, ...)              \
        {                                                       \
                .buswidth = __buswidth,                         \
                .opcode = __opcode,                             \
                .nbytes = 1,                                    \
+               __VA_ARGS__                                     \
        }
 
-#define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)           \
+#define SPI_MEM_OP_EXT_CMD(__nbytes, __opcode, __buswidth, ...)        \
+       {                                                       \
+               .buswidth = __buswidth,                         \
+               .opcode = __opcode,                             \
+               .nbytes = __nbytes,                             \
+               __VA_ARGS__                                     \
+       }
+
+#define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth, ...)      \
        {                                                       \
                .nbytes = __nbytes,                             \
                .val = __val,                                   \
                .buswidth = __buswidth,                         \
+               __VA_ARGS__                                     \
        }
 
 #define SPI_MEM_OP_NO_ADDR     { }
 
-#define SPI_MEM_OP_DUMMY(__nbytes, __buswidth)                 \
+#define SPI_MEM_OP_DUMMY(__nbytes, __buswidth, ...)            \
        {                                                       \
                .nbytes = __nbytes,                             \
                .buswidth = __buswidth,                         \
+               __VA_ARGS__                                     \
        }
 
 #define SPI_MEM_OP_NO_DUMMY    { }
 
-#define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth)                \
+#define SPI_MEM_OP_DATA_IN(__nbytes, __buf, __buswidth, ...)   \
        {                                                       \
                .dir = SPI_MEM_DATA_IN,                         \
                .nbytes = __nbytes,                             \
                .buf.in = __buf,                                \
                .buswidth = __buswidth,                         \
+               __VA_ARGS__                                     \
        }
 
-#define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth)       \
+#define SPI_MEM_OP_DATA_OUT(__nbytes, __buf, __buswidth, ...)  \
        {                                                       \
                .dir = SPI_MEM_DATA_OUT,                        \
                .nbytes = __nbytes,                             \
                .buf.out = __buf,                               \
                .buswidth = __buswidth,                         \
+               __VA_ARGS__                                     \
        }
 
 #define SPI_MEM_OP_NO_DATA     { }

and you get to define a DTR op like that:

	struct spi_mem_op op =
		SPI_MEM_OP(SPI_MEM_OP_EXT_CMD(2, 0x1234, 8, SPI_MEM_OP_DTR),
			   SPI_MEM_OP_ADDR(4, 0xdeadbeef, 8, SPI_MEM_OP_DTR),
			   SPI_MEM_OP_DATA_OUT(128, buf, 8, SPI_MEM_OP_DTR));

This also means we can extend the struct without having to define new macros.
