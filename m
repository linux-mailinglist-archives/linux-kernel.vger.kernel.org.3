Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76B424B682E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiBOJug convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 15 Feb 2022 04:50:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbiBOJud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:50:33 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03863101F16;
        Tue, 15 Feb 2022 01:50:21 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nJuTR-0006so-Ep; Tue, 15 Feb 2022 10:50:17 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Atish Kumar Patra <atishp@rivosinc.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree <devicetree@vger.kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/6] RISC-V: Implement multi-letter ISA extension probing framework
Date:   Tue, 15 Feb 2022 10:50:16 +0100
Message-ID: <5047719.XZAooIIPeM@diego>
In-Reply-To: <3135135.4LZR2ihtLn@diego>
References: <20220210214018.55739-1-atishp@rivosinc.com> <CAHBxVyGSB-LjTEwLXrw_UKn+VB56k6GtH7P8hMvU7qB530PqEA@mail.gmail.com> <3135135.4LZR2ihtLn@diego>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 15. Februar 2022, 10:48:16 CET schrieb Heiko Stübner:
> Am Dienstag, 15. Februar 2022, 10:12:53 CET schrieb Atish Kumar Patra:
> > On Mon, Feb 14, 2022 at 3:22 PM Atish Kumar Patra <atishp@rivosinc.com> wrote:
> > >
> > > On Mon, Feb 14, 2022 at 2:22 PM Heiko Stübner <heiko@sntech.de> wrote:
> > > >
> > > > Am Montag, 14. Februar 2022, 21:42:32 CET schrieb Atish Patra:
> > > > > On Mon, Feb 14, 2022 at 12:24 PM Heiko Stübner <heiko@sntech.de> wrote:
> > > > > >
> > > > > > Am Montag, 14. Februar 2022, 21:14:13 CET schrieb Atish Patra:
> > > > > > > On Mon, Feb 14, 2022 at 12:06 PM Heiko Stübner <heiko@sntech.de> wrote:
> > > > > > > >
> > > > > > > > Am Donnerstag, 10. Februar 2022, 22:40:16 CET schrieb Atish Patra:
> > > > > > > > > Multi-letter extensions can be probed using exising
> > > > > > > > > riscv_isa_extension_available API now. It doesn't support versioning
> > > > > > > > > right now as there is no use case for it.
> > > > > > > > > Individual extension specific implementation will be added during
> > > > > > > > > each extension support.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > > > > > > >
> > > > > > > > Tested-by: Heiko Stuebner <heiko@sntech.de>
> > > > > > > >
> > > > > > > >
> > > > > > > > By the way, does a similar parsing exist for opensbi as well?
> > > > > > > > Things like svpbmt as well as zicbom have CSR bits controlling how
> > > > > > > > these functions should behave (enabling them, etc), so I guess
> > > > > > > > opensbi also needs to parse the extensions from the ISA string?
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > > No. Currently, OpenSBI relies on the CSR read/write & trap method to
> > > > > > > identify the extensions [1].
> > > > > > >
> > > > > > > https://github.com/riscv-software-src/opensbi/blob/master/lib/sbi/sbi_hart.c#L404
> > > > > >
> > > > > > I guess my question is more, who is supposed to set CBIE, CBCFE bits in the
> > > > > > ENVCFG CSR. I.e. at it's default settings CMO instructions will cause
> > > > > > illegal instructions until the level above does allow them.
> > > > > >
> > > > > > When the kernel wants to call a cache-invalidate, from my reading menvcfg
> > > > > > needs to be modified accordingly - which would fall in SBI's court?
> > > > > >
> > > > >
> > > > > I think so. I had the same question for the SSTC extension as well.
> > > > > This is what I currently do:
> > > > >
> > > > > 1. Detect menvcfg first, detect stimecmp
> > > > > 2. Enable SSTC feature only if both are available
> > > > > 3. Set the STCE bit in menvcfg if SSTC is available
> > > > >
> > > > > Here is the patch
> > > > > https://github.com/atishp04/opensbi/commit/e6b185821e8302bffdceb4633b413252e0de4889
> > > >
> > > > Hmm, the CBO fields are defined as WARL (write any, read legal),
> > > > so I guess some sort of trap won't work here.
> > > >
> > >
> > > Correct. Traps for extensions that introduce new CSRs.
> > > I was suggesting setting the corresponding bits in MENVCFG and reading
> > > it again to check if it sticks.
> > >
> > > > The priv-spec only points to the cmo-spec for these bits and the cmo-spec
> > > > does not specifiy what the value should be when cmo is not present.
> > > >
> > > >
> > > > > > > In the future, zicbom can be detected in the same manner. However,
> > > > > > > svpbmt is a bit tricky as it doesn't
> > > > > > > define any new CSR. Do you think OpenSBI needs to detect svpbmt for any reason ?
> > > > > >
> > > > > > There is the PBMTE bit in MENVCFG, which I found while looking through the
> > > > > > zicbom-parts, which is supposed to "control wheter svpbmt is available for
> > > > > > use". So I guess the question is the same as above :-)
> > > > > >
> > > > >
> > > > > PBMTE bit in MENVCFG says if PBMTE bit is available or not. OpenSBI
> > > > > needs other way to
> > > > > detect if PBMTE is available.
> > > > >
> > > > > That's why, I think MENVCFG should be set correctly by the hardware
> > > > > upon reset. What do you think
> > > > > about that ? I couldn't find anything related to the reset state for menvcfg.
> > > >
> > > > me neither. Both the priv-spec as well as the cmobase spec do not
> > > > specifiy any reset-values it seems.
> > > >
> > > I have raised an issue in the ISA spec.
> > > https://github.com/riscv/riscv-isa-manual/issues/820
> > >
> > > > So I guess in the Qemu case, Qemu needs to set that bit when
> > > > its svpbmt extension is enabled?
> > > >
> > >
> > > We can do that if the priv spec is modified to allow that.
> > >
> > 
> > As per Greg's response, hardware is not expected to do that.
> > So we have to dynamically detect the extensions in OpenSBI and write to menvcfg.

Doesn't SBI also get the devicetree and could therefore parse
the ISA string for extensions? Might be less volatile and would
have both Kernel and SBI do the same thing for detection.


> > I am not sure what needs to be done for CBIE bits as it both flush(01)
> > or invalidate(11) are valid values
> 
> From looking at the security remark in the cmo-spec, I guess flush would be
> the appropriate thing to do?
> 
> "Until a modified cache block has updated memory, a CBO.INVAL instruction may expose stale data values
> in memory if the CSRs are programmed to perform an invalidate operation. This behavior may result in a
> security hole if lower privileged level software performs an invalidate operation and accesses sensitive
> information in memory."
> 
> But also do we actually _want_ to enable cmo always ... Greg was talking
> about backwards compatiblity in his response as well.
> 




