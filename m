Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1862451E280
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 01:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444432AbiEFWtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 18:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355180AbiEFWtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 18:49:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D9A6178;
        Fri,  6 May 2022 15:45:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16CA3B839F2;
        Fri,  6 May 2022 22:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0507C385A9;
        Fri,  6 May 2022 22:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651877131;
        bh=ftQi9qulEY2Jbu8EVZNt2L7N4exOH1BNtakTytErLyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c8d3OOqMGXj57v4mi+9T4R02tGJd+aIpFoPUq1lqiKNoidczMWLbMRGQHKRaqxEDb
         3iar4mxH9WpOaj+4EFGsZFgsrMl4Nv28WRylquof1j76ehM95x7wvKGXEzugGX0aUU
         o7cFkxS9vIYv/2cBM5QeE32yx9Lec7fw/pJvbdkna+mYV15ezSV487sy6eTtQbqVVp
         mpya6rWs3lYSY0H2tJaoWp4dV4mrxtsDMH6POX7AhX5ivnT/Mc5eYCQNQkhPk30Vvi
         AGBNyp4l9x8+gUIW6Q2Iz1L+Ds6Db3DRBK+xMurkRKps68aO5G1dO6DiVKnTJTxTYp
         JmZdd9U6zUszA==
Date:   Fri, 6 May 2022 15:45:28 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3 00/15] kbuild: yet another series of cleanups
 (modpost, LTO, MODULE_REL_CRCS)
Message-ID: <YnWlCH2tfr5YMb1/@dev-arch.thelio-3990X>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Thu, May 05, 2022 at 04:22:29PM +0900, Masahiro Yamada wrote:
> 
> This is the third batch of cleanups in this development cycle.
> 
> Major changes in v3:
> 
>  - Generate symbol CRCs as C code, and remove CONFIG_MODULE_REL_CRCS.
> 
> Major changes in v2:
> 
>  - V1 did not work with CONFIG_MODULE_REL_CRCS.
>    I fixed this for v2.
> 
>  - Reflect some review comments in v1
> 
>  - Refactor the code more
> 
>  - Avoid too long argument error
> 
> 
> Masahiro Yamada (15):
>   modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
>   modpost: change the license of EXPORT_SYMBOL to bool type
>   modpost: merge add_{intree_flag,retpoline,staging_flag} to add_header
>   modpost: move *.mod.c generation to write_mod_c_files()
>   kbuild: generate a list of objects in vmlinux
>   kbuild: record symbol versions in *.cmd files
>   modpost: extract symbol versions from *.cmd files
>   kbuild: link symbol CRCs at final link, removing
>     CONFIG_MODULE_REL_CRCS
>   kbuild: stop merging *.symversions
>   genksyms: adjust the output format to modpost
>   kbuild: do not create *.prelink.o for Clang LTO or IBT
>   modpost: simplify the ->is_static initialization
>   modpost: use hlist for hash table implementation
>   kbuild: make built-in.a rule robust against too long argument error
>   kbuild: make *.mod rule robust against too long argument error

I merged this series into mainline and tested an Arch Linux
x86_64 configuration and Fedora aarch64 configuration with ThinLTO and
saw no new warnings or issues. Modules loaded just fine in QEMU for Arch
Linux and I did not notice any boot issues or warnings.

Tested-by: Nathan Chancellor <nathan@kernel.org>

Cheers,
Nathan
