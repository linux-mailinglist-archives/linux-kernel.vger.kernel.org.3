Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9743E519244
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 01:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiECXZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 19:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244230AbiECXZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 19:25:22 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EF942ECD;
        Tue,  3 May 2022 16:21:44 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nm1pd-0004Xd-6L; Wed, 04 May 2022 01:21:25 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Anup Patel <anup@brainfault.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-man@vger.kernel.org, Jiatai He <jiatai2021@iscas.ac.cn>,
        "Hongren (Zenithal) Zheng" <i@zenithal.me>
Subject: Re: [PATCH 1/3] RISC-V: add Bitmanip/Scalar Crypto parsing from DT
Date:   Wed, 04 May 2022 01:21:23 +0200
Message-ID: <4734719.31r3eYUQgx@phil>
In-Reply-To: <Ym0+nr9KZBO118Dx@Sun>
References: <Ym0+Erz5DEnB78vu@Sun> <Ym0+nr9KZBO118Dx@Sun>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 30. April 2022, 15:50:22 CEST schrieb Hongren (Zenithal) Zheng:
> This commit parses Zb/Zk related string from DT and
> output them in cpuinfo
> 
> One thing worth noting is that if DT provides zk,
> all zbkb, zbkc, zbkx and zkn, zkr, zkt would be enabled.
> 
> Note that zk is a valid extension name and the current
> DT binding spec allows this.
> 
> There currently lacks a mechanism to merge them when
> producing cpuinfo. Namely if you provide a riscv,isa
> "rv64imafdc_zk_zks", the cpuinfo output would be
> "rv64imafdc_zbkb_zbkc_zbkx_zknd_zkne_zknh_zkr_zksed
> _zksh_zkt"
> 
> Tested-by: Jiatai He <jiatai2021@iscas.ac.cn>
> Signed-off-by: Hongren (Zenithal) Zheng <i@zenithal.me>
> ---
>  arch/riscv/include/asm/hwcap.h | 14 ++++++++++++++
>  arch/riscv/kernel/cpu.c        | 14 ++++++++++++++
>  arch/riscv/kernel/cpufeature.c | 33 +++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 0734e42f74f2..199eda39e0b8 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -52,6 +52,20 @@ extern unsigned long elf_hwcap;
>   */
>  enum riscv_isa_ext_id {
>  	RISCV_ISA_EXT_SSCOFPMF = RISCV_ISA_EXT_BASE,
> +	RISCV_ISA_EXT_ZBA,
> +	RISCV_ISA_EXT_ZBB,
> +	RISCV_ISA_EXT_ZBC,
> +	RISCV_ISA_EXT_ZBS,
> +	RISCV_ISA_EXT_ZBKB,
> +	RISCV_ISA_EXT_ZBKC,
> +	RISCV_ISA_EXT_ZBKX,
> +	RISCV_ISA_EXT_ZKNE,
> +	RISCV_ISA_EXT_ZKND,
> +	RISCV_ISA_EXT_ZKNH,
> +	RISCV_ISA_EXT_ZKSED,
> +	RISCV_ISA_EXT_ZKSH,
> +	RISCV_ISA_EXT_ZKR,
> +	RISCV_ISA_EXT_ZKT,
>  	RISCV_ISA_EXT_ID_MAX = RISCV_ISA_EXT_MAX,
>  };
>  
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index ccb617791e56..7251336969c1 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -87,6 +87,20 @@ int riscv_of_parent_hartid(struct device_node *node)
>   *    extensions by an underscore.
>   */
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
> +	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
> +	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
> +	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
> +	__RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
> +	__RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
> +	__RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
> +	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
> +	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
> +	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
> +	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
> +	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
> +	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
> +	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
> +	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
>  	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),

I guess a bit of sorting rule might be helpful, here it's the additions
above sscofpmf while in the enum it's the other way around.

As the list will get a long longer over time, I guess consistency
might improve readability.

>  	__RISCV_ISA_EXT_DATA("", RISCV_ISA_EXT_MAX),
>  };
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 1b2d42d7f589..10f9daf3734e 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -192,6 +192,39 @@ void __init riscv_fill_hwcap(void)
>  				set_bit(*ext - 'a', this_isa);
>  			} else {
>  				SET_ISA_EXT_MAP("sscofpmf", RISCV_ISA_EXT_SSCOFPMF);
> +				SET_ISA_EXT_MAP("zba"     , RISCV_ISA_EXT_ZBA     );

not sure if the additional whitespaces are really necessary? [especially the ones at the end]
What did checkpatch have to say about them?

> +				SET_ISA_EXT_MAP("zbb"     , RISCV_ISA_EXT_ZBB     );
> +				SET_ISA_EXT_MAP("zbc"     , RISCV_ISA_EXT_ZBC     );
> +				SET_ISA_EXT_MAP("zbs"     , RISCV_ISA_EXT_ZBS     );
> +				SET_ISA_EXT_MAP("zbkb"    , RISCV_ISA_EXT_ZBKB    );
> +				SET_ISA_EXT_MAP("zbkc"    , RISCV_ISA_EXT_ZBKC    );
> +				SET_ISA_EXT_MAP("zbks"    , RISCV_ISA_EXT_ZBKX    );
> +				SET_ISA_EXT_MAP("zknd"    , RISCV_ISA_EXT_ZKND    );
> +				SET_ISA_EXT_MAP("zkne"    , RISCV_ISA_EXT_ZKNE    );
> +				SET_ISA_EXT_MAP("zknh"    , RISCV_ISA_EXT_ZKNH    );
> +				SET_ISA_EXT_MAP("zksed"   , RISCV_ISA_EXT_ZKSED   );
> +				SET_ISA_EXT_MAP("zksh"    , RISCV_ISA_EXT_ZKSH    );
> +				SET_ISA_EXT_MAP("zkr"     , RISCV_ISA_EXT_ZKR     );
> +				SET_ISA_EXT_MAP("zkt"     , RISCV_ISA_EXT_ZKT     );
> +				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZBKB    );
> +				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZBKC    );
> +				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZBKX    );
> +				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZKND    );
> +				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZKNE    );
> +				SET_ISA_EXT_MAP("zkn"     , RISCV_ISA_EXT_ZKNH    );
> +				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZBKB    );
> +				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZBKC    );
> +				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZBKX    );
> +				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZKSED   );
> +				SET_ISA_EXT_MAP("zks"     , RISCV_ISA_EXT_ZKSH    );
> +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZBKB    );
> +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZBKC    );
> +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZBKX    );
> +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKND    );
> +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKNE    );
> +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKNH    );
> +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKR     );
> +				SET_ISA_EXT_MAP("zk"      , RISCV_ISA_EXT_ZKT     );
>  			}
>  #undef SET_ISA_EXT_MAP
>  		}
> 




