Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7564598301
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244600AbiHRMP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244595AbiHRMP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:15:27 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E36BA00C0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 05:15:23 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 9E9C45FD02;
        Thu, 18 Aug 2022 15:15:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660824921;
        bh=Ra0ds5CnY5m0hCc8oF9W8CIyDmlncOaykK7yrT2MQN0=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=ROb767SewNHk6KbMA/s1QXflrgQrZBdu3Fp57W+5pG7g2VsU8jqD+30WhasjcChFM
         u7Q8nAkI88l1m30L1fXs6LHBOgsBE+yL2O9oFWxjHgZTqo6RC4Wa+4AEgVB9fXtDy4
         PUttbm/Q+QkTtUJ3BC/sp44StRd49BuU2CsObs/Z4DLSPhdQhqgLGdWE9vFxBDJhTy
         cayfwX6yd2+OEpSc4fIvApESbNfOBnf9dICQ5ajvHKH7i5+5ZALaCDJjSBV/dkm4tt
         d2Lklofk8LUBspmSD2HjlyCtK+TGJtD001ZRHXZDajA300BAJw3W85VC20Fd1P2AJe
         DIzogL3qnb7JA==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 18 Aug 2022 15:15:20 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux@rasmusvillemoes.dk>" <linux@rasmusvillemoes.dk>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "maz@kernel.org>" <maz@kernel.org>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC:     kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
Thread-Topic: [PATCH v1] regmap: introduce value tracing for regmap bulk
 operations
Thread-Index: AQHYsZwRTOzZdLxKvkqpBNcAgWIdzq20YtWA
Date:   Thu, 18 Aug 2022 12:15:00 +0000
Message-ID: <20220818121515.6azkxyqetnunwsc6@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20220816181451.5628-1-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AC9EAFFC92E14A4EA157ADBF6AF36FBC@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/18 08:17:00 #20129731
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Thomas, Rasmus and Marc

On Tue, Aug 16, 2022 at 06:14:48PM +0000, Dmitry Rokosov wrote:
> Currently, only one-register io operations support tracepoints with
> value logging. For the regmap bulk operations developer can view
> hw_start/hw_done tracepoints with starting reg number and registers
> count to be reading or writing. This patch injects tracepoints with
> dumping registers values in the hex format to regmap bulk reading
> and writing.
>=20
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  drivers/base/regmap/regmap.c |  7 ++++++
>  drivers/base/regmap/trace.h  | 43 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
>=20
> diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
> index c3517ccc3159..673ad37df11f 100644
> --- a/drivers/base/regmap/regmap.c
> +++ b/drivers/base/regmap/regmap.c
> @@ -2323,6 +2323,10 @@ int regmap_bulk_write(struct regmap *map, unsigned=
 int reg, const void *val,
> =20
>  		kfree(wval);
>  	}
> +
> +	if (!ret)
> +		trace_regmap_bulk_write(map, reg, val, val_bytes * val_count);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(regmap_bulk_write);
> @@ -3068,6 +3072,9 @@ int regmap_bulk_read(struct regmap *map, unsigned i=
nt reg, void *val,
>  		map->unlock(map->lock_arg);
>  	}
> =20
> +	if (!ret)
> +		trace_regmap_bulk_read(map, reg, val, val_bytes * val_count);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(regmap_bulk_read);
> diff --git a/drivers/base/regmap/trace.h b/drivers/base/regmap/trace.h
> index 9abee14df9ee..04329ba68ec5 100644
> --- a/drivers/base/regmap/trace.h
> +++ b/drivers/base/regmap/trace.h
> @@ -64,6 +64,49 @@ DEFINE_EVENT(regmap_reg, regmap_reg_read_cache,
> =20
>  );
> =20
> +DECLARE_EVENT_CLASS(regmap_bulk,
> +
> +	TP_PROTO(struct regmap *map, unsigned int reg,
> +		 const void *val, int val_len),
> +
> +	TP_ARGS(map, reg, val, val_len),
> +
> +	TP_STRUCT__entry(
> +		__string(name, regmap_name(map))
> +		__field(unsigned int, reg)
> +		__dynamic_array(char, buf, val_len)
> +		__field(int, val_len)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(name, regmap_name(map));
> +		__entry->reg =3D reg;
> +		__entry->val_len =3D val_len;
> +		if (val)
> +			memcpy(__get_dynamic_array(buf), val, val_len);
> +	),
> +
> +	TP_printk("%s reg=3D%x val=3D%s", __get_str(name),
> +		  (unsigned int)__entry->reg,
> +		  __print_hex(__get_dynamic_array(buf), __entry->val_len))
> +);
> +
> +DEFINE_EVENT(regmap_bulk, regmap_bulk_write,
> +
> +	TP_PROTO(struct regmap *map, unsigned int reg,
> +		 const void *val, int val_len),
> +
> +	TP_ARGS(map, reg, val, val_len)
> +);
> +
> +DEFINE_EVENT(regmap_bulk, regmap_bulk_read,
> +
> +	TP_PROTO(struct regmap *map, unsigned int reg,
> +		 const void *val, int val_len),
> +
> +	TP_ARGS(map, reg, val, val_len)
> +);
> +
>  DECLARE_EVENT_CLASS(regmap_block,
> =20
>  	TP_PROTO(struct regmap *map, unsigned int reg, int count),
> --=20
> 2.36.0

--=20
Thank you,
Dmitry=
