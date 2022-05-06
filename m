Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002E351DCAF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443269AbiEFQDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345744AbiEFQDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:03:35 -0400
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14FC6D3AF
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:59:50 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwHm5t2lzMq1PX;
        Fri,  6 May 2022 17:59:48 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwHm3yxDzlhRVb;
        Fri,  6 May 2022 17:59:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651852788;
        bh=yitNexgF1Xp5971/mTG6kGNZaLtqiJLtFVV+lJnc2ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eE7fa2V5WVh7yhL2EdX0ElTtW9FGxnVkWrqwcpwQpPU/6d94+h9IGOxGI3nDPc2ZF
         b5nR+g3ROi7zw024iiHQ0v69vI+IRRc9VLkqK9rMYwlls1zVeR1qXKrkCe4WLZ92sI
         WuLCSswC+18ln2kzM8xPdvGWZ1jQbL+F6YcRK0hs=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Andy Whitcroft <apw@canonical.com>,
        Brian Norris <briannorris@chromium.org>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Joe Perches <joe@perches.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH v2 1/5] clang-format: Update and extend the for_each list with tools/
Date:   Fri,  6 May 2022 18:01:02 +0200
Message-Id: <20220506160106.522341-2-mic@digikod.net>
In-Reply-To: <20220506160106.522341-1-mic@digikod.net>
References: <20220506160106.522341-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add tools/ to the shell fragment generating the for_each list and update
it.  This is useful to format files in the tools directory (e.g.
selftests) with the same coding style as the kernel.

Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: Tom Rix <trix@redhat.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160106.522341-2-mic@digikod.net
---

Changes since v1:
* Update the exception list with v5.18-rc5.
---
 .clang-format | 177 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 149 insertions(+), 28 deletions(-)

diff --git a/.clang-format b/.clang-format
index fa959436bcfd..70d4e7ec4cf9 100644
--- a/.clang-format
+++ b/.clang-format
@@ -65,36 +65,53 @@ ExperimentalAutoDetectBinPacking: false
 #FixNamespaceComments: false # Unknown to clang-format-4.0
 
 # Taken from:
-#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' include/ \
+#   git grep -h '^#define [^[:space:]]*for_each[^[:space:]]*(' include/ tools/ \
 #   | sed "s,^#define \([^[:space:]]*for_each[^[:space:]]*\)(.*$,  - '\1'," \
 #   | sort | uniq
 ForEachMacros:
+  - '__ata_qc_for_each'
+  - '__bio_for_each_bvec'
+  - '__bio_for_each_segment'
+  - '__evlist__for_each_entry'
+  - '__evlist__for_each_entry_continue'
+  - '__evlist__for_each_entry_from'
+  - '__evlist__for_each_entry_reverse'
+  - '__evlist__for_each_entry_safe'
+  - '__for_each_mem_range'
+  - '__for_each_mem_range_rev'
+  - '__for_each_thread'
+  - '__hlist_for_each_rcu'
+  - '__map__for_each_symbol_by_name'
+  - '__perf_evlist__for_each_entry'
+  - '__perf_evlist__for_each_entry_reverse'
+  - '__perf_evlist__for_each_entry_safe'
+  - '__rq_for_each_bio'
+  - '__shost_for_each_device'
   - 'apei_estatus_for_each_section'
   - 'ata_for_each_dev'
   - 'ata_for_each_link'
-  - '__ata_qc_for_each'
   - 'ata_qc_for_each'
   - 'ata_qc_for_each_raw'
   - 'ata_qc_for_each_with_internal'
   - 'ax25_for_each'
   - 'ax25_uid_for_each'
-  - '__bio_for_each_bvec'
   - 'bio_for_each_bvec'
   - 'bio_for_each_bvec_all'
+  - 'bio_for_each_folio_all'
   - 'bio_for_each_integrity_vec'
-  - '__bio_for_each_segment'
   - 'bio_for_each_segment'
   - 'bio_for_each_segment_all'
   - 'bio_list_for_each'
   - 'bip_for_each_vec'
-  - 'bitmap_for_each_clear_region'
-  - 'bitmap_for_each_set_region'
-  - 'blkg_for_each_descendant_post'
-  - 'blkg_for_each_descendant_pre'
-  - 'blk_queue_for_each_rl'
   - 'bond_for_each_slave'
   - 'bond_for_each_slave_rcu'
+  - 'bpf__perf_for_each_map'
+  - 'bpf__perf_for_each_map_named'
   - 'bpf_for_each_spilled_reg'
+  - 'bpf_object__for_each_map'
+  - 'bpf_object__for_each_program'
+  - 'bpf_object__for_each_safe'
+  - 'bpf_perf_object__for_each'
   - 'btree_for_each_safe128'
   - 'btree_for_each_safe32'
   - 'btree_for_each_safe64'
@@ -102,6 +119,7 @@ ForEachMacros:
   - 'card_for_each_dev'
   - 'cgroup_taskset_for_each'
   - 'cgroup_taskset_for_each_leader'
+  - 'cpufreq_for_each_efficient_entry_idx'
   - 'cpufreq_for_each_entry'
   - 'cpufreq_for_each_entry_idx'
   - 'cpufreq_for_each_valid_entry'
@@ -109,9 +127,22 @@ ForEachMacros:
   - 'css_for_each_child'
   - 'css_for_each_descendant_post'
   - 'css_for_each_descendant_pre'
+  - 'damon_for_each_region'
+  - 'damon_for_each_region_safe'
+  - 'damon_for_each_scheme'
+  - 'damon_for_each_scheme_safe'
+  - 'damon_for_each_target'
+  - 'damon_for_each_target_safe'
+  - 'data__for_each_file'
+  - 'data__for_each_file_new'
+  - 'data__for_each_file_start'
   - 'device_for_each_child_node'
   - 'displayid_iter_for_each'
+  - 'dma_fence_array_for_each'
   - 'dma_fence_chain_for_each'
+  - 'dma_fence_unwrap_for_each'
+  - 'dma_resv_for_each_fence'
+  - 'dma_resv_for_each_fence_unlocked'
   - 'do_for_each_ftrace_op'
   - 'drm_atomic_crtc_for_each_plane'
   - 'drm_atomic_crtc_state_for_each_plane'
@@ -135,6 +166,25 @@ ForEachMacros:
   - 'drm_mm_for_each_node'
   - 'drm_mm_for_each_node_in_range'
   - 'drm_mm_for_each_node_safe'
+  - 'dsa_switch_for_each_available_port'
+  - 'dsa_switch_for_each_cpu_port'
+  - 'dsa_switch_for_each_port'
+  - 'dsa_switch_for_each_port_continue_reverse'
+  - 'dsa_switch_for_each_port_safe'
+  - 'dsa_switch_for_each_user_port'
+  - 'dsa_tree_for_each_user_port'
+  - 'dso__for_each_symbol'
+  - 'dsos__for_each_with_build_id'
+  - 'elf_hash_for_each_possible'
+  - 'elf_section__for_each_rel'
+  - 'elf_section__for_each_rela'
+  - 'elf_symtab__for_each_symbol'
+  - 'evlist__for_each_cpu'
+  - 'evlist__for_each_entry'
+  - 'evlist__for_each_entry_continue'
+  - 'evlist__for_each_entry_from'
+  - 'evlist__for_each_entry_reverse'
+  - 'evlist__for_each_entry_safe'
   - 'flow_action_for_each'
   - 'for_each_acpi_dev_match'
   - 'for_each_active_dev_scope'
@@ -142,8 +192,11 @@ ForEachMacros:
   - 'for_each_active_iommu'
   - 'for_each_aggr_pgid'
   - 'for_each_available_child_of_node'
+  - 'for_each_bench'
   - 'for_each_bio'
   - 'for_each_board_func_rsrc'
+  - 'for_each_btf_ext_rec'
+  - 'for_each_btf_ext_sec'
   - 'for_each_bvec'
   - 'for_each_card_auxs'
   - 'for_each_card_auxs_safe'
@@ -159,17 +212,22 @@ ForEachMacros:
   - 'for_each_child_of_node'
   - 'for_each_clear_bit'
   - 'for_each_clear_bit_from'
+  - 'for_each_clear_bitrange'
+  - 'for_each_clear_bitrange_from'
+  - 'for_each_cmd'
   - 'for_each_cmsghdr'
+  - 'for_each_collection'
+  - 'for_each_comp_order'
   - 'for_each_compatible_node'
   - 'for_each_component_dais'
   - 'for_each_component_dais_safe'
-  - 'for_each_comp_order'
   - 'for_each_console'
   - 'for_each_cpu'
   - 'for_each_cpu_and'
   - 'for_each_cpu_not'
   - 'for_each_cpu_wrap'
   - 'for_each_dapm_widgets'
+  - 'for_each_dedup_cand'
   - 'for_each_dev_addr'
   - 'for_each_dev_scope'
   - 'for_each_dma_cap_mask'
@@ -179,13 +237,14 @@ ForEachMacros:
   - 'for_each_dpcm_fe'
   - 'for_each_drhd_unit'
   - 'for_each_dss_dev'
-  - 'for_each_dtpm_table'
   - 'for_each_efi_memory_desc'
   - 'for_each_efi_memory_desc_in_map'
   - 'for_each_element'
   - 'for_each_element_extid'
   - 'for_each_element_id'
   - 'for_each_endpoint_of_node'
+  - 'for_each_event'
+  - 'for_each_event_tps'
   - 'for_each_evictable_lru'
   - 'for_each_fib6_node_rt_rcu'
   - 'for_each_fib6_walker_rt'
@@ -194,30 +253,35 @@ ForEachMacros:
   - 'for_each_free_mem_range'
   - 'for_each_free_mem_range_reverse'
   - 'for_each_func_rsrc'
+  - 'for_each_group_evsel'
+  - 'for_each_group_member'
   - 'for_each_hstate'
   - 'for_each_if'
+  - 'for_each_inject_fn'
+  - 'for_each_insn'
+  - 'for_each_insn_prefix'
+  - 'for_each_intid'
   - 'for_each_iommu'
   - 'for_each_ip_tunnel_rcu'
   - 'for_each_irq_nr'
+  - 'for_each_lang'
   - 'for_each_link_codecs'
   - 'for_each_link_cpus'
   - 'for_each_link_platforms'
   - 'for_each_lru'
   - 'for_each_matching_node'
   - 'for_each_matching_node_and_match'
-  - 'for_each_member'
-  - 'for_each_memcg_cache_index'
   - 'for_each_mem_pfn_range'
-  - '__for_each_mem_range'
   - 'for_each_mem_range'
-  - '__for_each_mem_range_rev'
   - 'for_each_mem_range_rev'
   - 'for_each_mem_region'
+  - 'for_each_member'
+  - 'for_each_memory'
   - 'for_each_migratetype_order'
-  - 'for_each_msi_entry'
-  - 'for_each_msi_entry_safe'
+  - 'for_each_missing_reg'
   - 'for_each_net'
   - 'for_each_net_continue_reverse'
+  - 'for_each_net_rcu'
   - 'for_each_netdev'
   - 'for_each_netdev_continue'
   - 'for_each_netdev_continue_rcu'
@@ -227,12 +291,13 @@ ForEachMacros:
   - 'for_each_netdev_rcu'
   - 'for_each_netdev_reverse'
   - 'for_each_netdev_safe'
-  - 'for_each_net_rcu'
   - 'for_each_new_connector_in_state'
   - 'for_each_new_crtc_in_state'
   - 'for_each_new_mst_mgr_in_state'
   - 'for_each_new_plane_in_state'
+  - 'for_each_new_plane_in_state_reverse'
   - 'for_each_new_private_obj_in_state'
+  - 'for_each_new_reg'
   - 'for_each_node'
   - 'for_each_node_by_name'
   - 'for_each_node_by_type'
@@ -248,20 +313,20 @@ ForEachMacros:
   - 'for_each_old_connector_in_state'
   - 'for_each_old_crtc_in_state'
   - 'for_each_old_mst_mgr_in_state'
+  - 'for_each_old_plane_in_state'
+  - 'for_each_old_private_obj_in_state'
   - 'for_each_oldnew_connector_in_state'
   - 'for_each_oldnew_crtc_in_state'
   - 'for_each_oldnew_mst_mgr_in_state'
   - 'for_each_oldnew_plane_in_state'
   - 'for_each_oldnew_plane_in_state_reverse'
   - 'for_each_oldnew_private_obj_in_state'
-  - 'for_each_old_plane_in_state'
-  - 'for_each_old_private_obj_in_state'
   - 'for_each_online_cpu'
   - 'for_each_online_node'
   - 'for_each_online_pgdat'
+  - 'for_each_path'
   - 'for_each_pci_bridge'
   - 'for_each_pci_dev'
-  - 'for_each_pci_msi_entry'
   - 'for_each_pcm_streams'
   - 'for_each_physmem_range'
   - 'for_each_populated_zone'
@@ -269,6 +334,7 @@ ForEachMacros:
   - 'for_each_present_cpu'
   - 'for_each_prime_number'
   - 'for_each_prime_number_from'
+  - 'for_each_probe_cache_entry'
   - 'for_each_process'
   - 'for_each_process_thread'
   - 'for_each_prop_codec_conf'
@@ -278,6 +344,8 @@ ForEachMacros:
   - 'for_each_prop_dlc_cpus'
   - 'for_each_prop_dlc_platforms'
   - 'for_each_property_of_node'
+  - 'for_each_reg'
+  - 'for_each_reg_filtered'
   - 'for_each_registered_fb'
   - 'for_each_requested_gpio'
   - 'for_each_requested_gpio_in_range'
@@ -287,8 +355,12 @@ ForEachMacros:
   - 'for_each_rtd_components'
   - 'for_each_rtd_cpu_dais'
   - 'for_each_rtd_dais'
+  - 'for_each_script'
+  - 'for_each_sec'
   - 'for_each_set_bit'
   - 'for_each_set_bit_from'
+  - 'for_each_set_bitrange'
+  - 'for_each_set_bitrange_from'
   - 'for_each_set_clump8'
   - 'for_each_sg'
   - 'for_each_sg_dma_page'
@@ -297,18 +369,25 @@ ForEachMacros:
   - 'for_each_sgtable_dma_sg'
   - 'for_each_sgtable_page'
   - 'for_each_sgtable_sg'
+  - 'for_each_shell_test'
   - 'for_each_sibling_event'
   - 'for_each_subelement'
   - 'for_each_subelement_extid'
   - 'for_each_subelement_id'
-  - '__for_each_thread'
+  - 'for_each_sublist'
+  - 'for_each_subsystem'
+  - 'for_each_supported_activate_fn'
+  - 'for_each_supported_inject_fn'
+  - 'for_each_test'
   - 'for_each_thread'
+  - 'for_each_token'
   - 'for_each_unicast_dest_pgid'
   - 'for_each_vsi'
   - 'for_each_wakeup_source'
   - 'for_each_zone'
   - 'for_each_zone_zonelist'
   - 'for_each_zone_zonelist_nodemask'
+  - 'func_for_each_insn'
   - 'fwnode_for_each_available_child_node'
   - 'fwnode_for_each_child_node'
   - 'fwnode_graph_for_each_endpoint'
@@ -322,7 +401,13 @@ ForEachMacros:
   - 'hash_for_each_possible_safe'
   - 'hash_for_each_rcu'
   - 'hash_for_each_safe'
+  - 'hashmap__for_each_entry'
+  - 'hashmap__for_each_entry_safe'
+  - 'hashmap__for_each_key_entry'
+  - 'hashmap__for_each_key_entry_safe'
   - 'hctx_for_each_ctx'
+  - 'hists__for_each_format'
+  - 'hists__for_each_sort_list'
   - 'hlist_bl_for_each_entry'
   - 'hlist_bl_for_each_entry_rcu'
   - 'hlist_bl_for_each_entry_safe'
@@ -338,7 +423,6 @@ ForEachMacros:
   - 'hlist_for_each_entry_rcu_notrace'
   - 'hlist_for_each_entry_safe'
   - 'hlist_for_each_entry_srcu'
-  - '__hlist_for_each_rcu'
   - 'hlist_for_each_safe'
   - 'hlist_nulls_for_each_entry'
   - 'hlist_nulls_for_each_entry_from'
@@ -346,9 +430,6 @@ ForEachMacros:
   - 'hlist_nulls_for_each_entry_safe'
   - 'i3c_bus_for_each_i2cdev'
   - 'i3c_bus_for_each_i3cdev'
-  - 'ide_host_for_each_port'
-  - 'ide_port_for_each_dev'
-  - 'ide_port_for_each_present_dev'
   - 'idr_for_each_entry'
   - 'idr_for_each_entry_continue'
   - 'idr_for_each_entry_continue_ul'
@@ -356,7 +437,12 @@ ForEachMacros:
   - 'in_dev_for_each_ifa_rcu'
   - 'in_dev_for_each_ifa_rtnl'
   - 'inet_bind_bucket_for_each'
+  - 'inet_lhash2_for_each_icsk'
+  - 'inet_lhash2_for_each_icsk_continue'
   - 'inet_lhash2_for_each_icsk_rcu'
+  - 'intlist__for_each_entry'
+  - 'intlist__for_each_entry_safe'
+  - 'kcore_copy__for_each_phdr'
   - 'key_for_each'
   - 'key_for_each_safe'
   - 'klp_for_each_func'
@@ -367,7 +453,9 @@ ForEachMacros:
   - 'klp_for_each_object_static'
   - 'kunit_suite_for_each_test_case'
   - 'kvm_for_each_memslot'
+  - 'kvm_for_each_memslot_in_gfn_range'
   - 'kvm_for_each_vcpu'
+  - 'libbpf_nla_for_each_attr'
   - 'list_for_each'
   - 'list_for_each_codec'
   - 'list_for_each_codec_safe'
@@ -387,6 +475,7 @@ ForEachMacros:
   - 'list_for_each_entry_safe_from'
   - 'list_for_each_entry_safe_reverse'
   - 'list_for_each_entry_srcu'
+  - 'list_for_each_from'
   - 'list_for_each_prev'
   - 'list_for_each_prev_safe'
   - 'list_for_each_safe'
@@ -394,11 +483,18 @@ ForEachMacros:
   - 'llist_for_each_entry'
   - 'llist_for_each_entry_safe'
   - 'llist_for_each_safe'
+  - 'map__for_each_symbol'
+  - 'map__for_each_symbol_by_name'
+  - 'map_for_each_event'
+  - 'map_for_each_metric'
+  - 'maps__for_each_entry'
+  - 'maps__for_each_entry_safe'
   - 'mci_for_each_dimm'
   - 'media_device_for_each_entity'
   - 'media_device_for_each_intf'
   - 'media_device_for_each_link'
   - 'media_device_for_each_pad'
+  - 'msi_for_each_desc'
   - 'nanddev_io_for_each_page'
   - 'netdev_for_each_lower_dev'
   - 'netdev_for_each_lower_private'
@@ -423,6 +519,20 @@ ForEachMacros:
   - 'pcl_for_each_chunk'
   - 'pcl_for_each_segment'
   - 'pcm_for_each_format'
+  - 'perf_config_items__for_each_entry'
+  - 'perf_config_sections__for_each_entry'
+  - 'perf_config_set__for_each_entry'
+  - 'perf_cpu_map__for_each_cpu'
+  - 'perf_evlist__for_each_entry'
+  - 'perf_evlist__for_each_entry_reverse'
+  - 'perf_evlist__for_each_entry_safe'
+  - 'perf_evlist__for_each_evsel'
+  - 'perf_evlist__for_each_mmap'
+  - 'perf_hpp_list__for_each_format'
+  - 'perf_hpp_list__for_each_format_safe'
+  - 'perf_hpp_list__for_each_sort_list'
+  - 'perf_hpp_list__for_each_sort_list_safe'
+  - 'perf_pmu__for_each_hybrid_pmu'
   - 'ping_portaddr_for_each_entry'
   - 'plist_for_each'
   - 'plist_for_each_continue'
@@ -442,6 +552,7 @@ ForEachMacros:
   - 'rdma_for_each_block'
   - 'rdma_for_each_port'
   - 'rdma_umem_for_each_dma_block'
+  - 'resort_rb__for_each_entry'
   - 'resource_list_for_each_entry'
   - 'resource_list_for_each_entry_safe'
   - 'rhl_for_each_entry_rcu'
@@ -455,15 +566,18 @@ ForEachMacros:
   - 'rht_for_each_from'
   - 'rht_for_each_rcu'
   - 'rht_for_each_rcu_from'
-  - '__rq_for_each_bio'
   - 'rq_for_each_bvec'
   - 'rq_for_each_segment'
+  - 'rq_list_for_each'
+  - 'rq_list_for_each_safe'
   - 'scsi_for_each_prot_sg'
   - 'scsi_for_each_sg'
   - 'sctp_for_each_hentry'
   - 'sctp_skb_for_each'
+  - 'sec_for_each_insn'
+  - 'sec_for_each_insn_continue'
+  - 'sec_for_each_insn_from'
   - 'shdma_for_each_chan'
-  - '__shost_for_each_device'
   - 'shost_for_each_device'
   - 'sk_for_each'
   - 'sk_for_each_bound'
@@ -480,7 +594,13 @@ ForEachMacros:
   - 'snd_soc_dapm_widget_for_each_path_safe'
   - 'snd_soc_dapm_widget_for_each_sink_path'
   - 'snd_soc_dapm_widget_for_each_source_path'
+  - 'strlist__for_each_entry'
+  - 'strlist__for_each_entry_safe'
+  - 'sym_for_each_insn'
+  - 'sym_for_each_insn_continue_reverse'
+  - 'symbols__for_each_entry'
   - 'tb_property_for_each'
+  - 'tcf_act_for_each_action'
   - 'tcf_exts_for_each_action'
   - 'udp_portaddr_for_each_entry'
   - 'udp_portaddr_for_each_entry_rcu'
@@ -504,6 +624,7 @@ ForEachMacros:
   - 'xbc_node_for_each_array_value'
   - 'xbc_node_for_each_child'
   - 'xbc_node_for_each_key_value'
+  - 'xbc_node_for_each_subkey'
   - 'zorro_for_each_dev'
 
 #IncludeBlocks: Preserve # Unknown to clang-format-5.0
-- 
2.35.1

