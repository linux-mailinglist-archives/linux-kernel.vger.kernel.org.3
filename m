Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F774E721F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353963AbiCYLZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238578AbiCYLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:25:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FD970CE4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 04:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648207445;
        bh=BdXWivSq5GlXvd3nq8851jS/bg73TKqNgmm9MNsH8Gk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=f6mVd1+ulo7Iuu25wuaQ9r8ZotOvxGfZkV4m5CdWHAbvwY7ij+zSwrKFS2paqKLSi
         LMBBe4zzdslT2lrm4SW4D2e9xXIOmsMdwyDwVwSEgpvrMy3BUWfn5060pb5GeqWeI/
         ePeft1WoakMNjguGrRfh8SY0lhTQDfNpTqzlYKnM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.219.67]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MplXp-1npz6e0MI9-00qCFF; Fri, 25
 Mar 2022 12:24:05 +0100
Message-ID: <7e69287265bf6dd2e775afab73cbbf5ff3647257.camel@gmx.de>
Subject: Re: new ltp memcg gripe bisects to b67bf49ce7aa ("post mm/munlock:
 delete FOLL_MLOCK and FOLL_POPULATE")
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Hugh Dickins <hughd@google.com>
Date:   Fri, 25 Mar 2022 12:24:04 +0100
In-Reply-To: <969a2030a492f3cecdb7d0095478f1b779c643c3.camel@gmx.de>
References: <969a2030a492f3cecdb7d0095478f1b779c643c3.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kaETVRfvE/N0qmqG8u292jAZ1RQKoCeuuhRgNRYuGI0xSsnmnmf
 gd27mKQgPVVLBierfa2oDekEcsY2+ZVTjZh25tUkEunrS1KEaCaenS0PaZKyiseGquNzNaE
 1YRPfYoGT/p5DcY+V4hclR8OevuwNK8q/BxldZ38YbWPX5MP1n6gSHvJ9zWOQfxu3NmQgCr
 DqqQlmnwtfy6U2msRrmDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZUD0R0ex5AY=:+6uSCF+/rjYpVjMwtz4uoI
 qh2Cid/KExfVEqOF8goTdoCDKxVGZchQOJDiqrhDPIPNY8WYqttsyerHb40B6rZ4YScFlEnXL
 37EVAupezcQ76YgtGEbt/7wFG3zKkRfH0pKYeO+ZO/Ne3qt1A0Ca9oQMfDPUlLv1ugrqcLL7O
 a9Y7/uc+hAca2Q1uohOe8g7tPfLrOTFz4y/4H2PZUwX5bBEtBCFc5rbriRBd6xEe2qJgbyg0W
 LhJx4yWp2OnEMvUYYrD8JLoTQzigyK76OX4nyopgSkcjIUlL0XL6ksO6otzcVVFB0qEryFGZ6
 nd8yTBiiiZa5d8JCzToLTgvPC82YV6ERHARfcQVeGzI0P8UunKzKXFSjHtoeI40OkBE4uEVKZ
 dpOJP2GAOyYHc84CWJevOuJ9msrispzzXnH/gtl5ehrB1l3fyt+sXaRmHPUwFSo8xguOsC4v+
 2M1pfyfOM1X9sXOxVnnhlLVmwQUqOArjKckJBlHI8sVPiaPoeq2hH7xsSxJ32u4EcS5rInYbs
 wzx6SJHKlxgo9BWYj0vUIPDjCbryM9IgYhNbsjj/Um0uRydyypAJTAKh++PtMn7eFiEehQWNT
 mdjppdyDf+3IhnqqpdKlbh9tHxZzJYnDEHXuBMDliWdQ6WhaFbAVqosuy0tEjkIF+d3pCHl9g
 llUKIxbVGKXn32kWIJJ5mJR9t3aF1PTKqGWJViGmCEdJ1aMyEgYfIHA6MnALPpbn4djsOYGsP
 cjF7c5dnNBeQQxTQcbDJPfiAvmEY4e52PRFHegWIQXwsSNMSq1+JBLx8HBFogYkl76QOVsDDr
 mBE5wYoq6hXbA7U07p8dJcDTjyuqyEsNsGjTHHrIkIIZiDHEQP5sH9bPAKTwsVbnTA5Ws1dfg
 /Oi9V2xiXbdP2RgMLmSYqNP5oS50AB1v5+Yy8hD87dhuHGgqCcK2yL19Id1S7e5d3auy61rLP
 6YJKb3zcHA54uCUFTyy9X3a3ClQUem3MXk9ebJ9F491ed59JsD/egsAQzMhTRxC0gIRoRwnmT
 Hy53EC9SXdWA/kUxymhYWhsRMLR5hxfTSTqtzScDEAWZes3vrZPw2Cp7puvvpr6RqQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-25 at 11:32 +0100, Mike Galbraith wrote:
>
> I wanted to verify with a revert on top of 85c7000fda00, but while the
> revert patch applied, the result didn't boot.=C2=A0 Config is full distr=
o.

Actually, with the second build bandaid (ahem) fixed up to really
really build, revert patch (seemingly) validates the bisection.  All
memcg tests are again green.

	-Mike
